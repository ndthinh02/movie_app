import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/commom/bloc/theme/app_theme_bloc.dart';
import 'package:movie_app/commom/extensions/setting_enum.dart';
import 'package:movie_app/commom/widgets/indicator.dart';
import 'package:movie_app/features/setting/presentation/widgets/setting_widget.dart';

import '../../../../core/constant/constants.dart';
import '../../../../di.dart';
import '../../../../route/route_name.dart';
import '../../../auth/data/data_source/auth_service.dart';
import '../bloc/setting_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SettingBloc>().add(GetUser());
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final stateTheme = context.read<AppThemeBloc>().state;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(child: IndicatorCommom());
              }
              if (state is UserLoadSuccess) {
                return Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            state.userEntity?.urlImage ?? defaultImg,
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.userEntity?.username ?? 'null',
                              style: text.headlineSmall,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Text(
                              state.userEntity?.email ?? '',
                              style: text.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ...(SettingEnum.values).map(
                      (e) => InkWell(
                        onTap: () => _chooseOption(
                          context,
                          e,
                          state.userEntity?.username ?? '',
                          state.userEntity?.urlImage ?? defaultImg,
                        ),
                        child: SettingWidget(
                          icon: e.icon(context),
                          title: e.title(
                            context,
                            stateTheme.isDarkTheme!,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
              if (state is UserLoadFailed) {
                return const Icon(
                  Icons.error,
                  color: Colors.red,
                );
              }
              return const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _chooseOption(
    BuildContext context,
    SettingEnum option,
    String username,
    String urlImage,
  ) {
    switch (option) {
      case SettingEnum.account:
        {
          Navigator.of(context).pushNamed(RouteName.account, arguments: {
            'urlImage': urlImage,
            'username': username,
          });
          break;
        }
      case SettingEnum.darkMode:
        {
          context.read<AppThemeBloc>().add(ToggleChangeTheme());
          break;
        }
      case SettingEnum.language:
        {
          Navigator.of(context).pushNamed(RouteName.language);
          break;
        }
      case SettingEnum.watchHistory:
        {
          Navigator.of(context).pushNamed(RouteName.watchHistory);
          break;
        }
      case SettingEnum.notification:
        {
          break;
        }
      case SettingEnum.signOut:
        {
          getIt<AuthService>().signOut(context).whenComplete(
                () => Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteName.login,
                  (route) => false,
                ),
              );
          break;
        }
      default:
        {
          break;
        }
    }
  }
}
