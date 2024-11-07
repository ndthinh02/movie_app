import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/features/home/presentation/widgets/home_shimmer_widget.dart';
import 'package:movie_app/features/home/presentation/widgets/new_movie_widget.dart';
import 'package:movie_app/features/home/presentation/widgets/title_widget.dart';

import '../../../../commom/bloc/language/language_bloc.dart';
import '../../../../core/constant/constants.dart';
import '../../../../route/route_name.dart';
import '../../data/models/commom_movie_model.dart';
import '../widgets/commom_movie_widget.dart';
import '../widgets/single_movie_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(Init());
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final themeText = Theme.of(context).textTheme;
    final ss = context.read<LanguageBloc>().state;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeMovieInitial) {
              return const HomeShimmerWidget();
            }
            if (state is HomeLoadSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => _navigateSearchScreen(),
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    state.listItems?.length == 0
                        ? const SizedBox()
                        : NewMovieWidget(
                            items: state.listItems ?? [],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    TitleWidget(
                      title: text.single_movie,
                      type: typeSingleMovie,
                      name: text.single_movie,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SingleMovieWidget(
                            items: state.listSingleMovie?[index] ?? DataItems(),
                            onPress: () => _navigateDetailScreen(
                              state.listSingleMovie?[index] ?? DataItems(),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 16,
                        ),
                        itemCount: (state.listSingleMovie?.length ?? 0) >= 7
                            ? 10
                            : (state.listSingleMovie?.length ?? 0),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TitleWidget(
                      type: typeSeriesMovie,
                      title: text.series,
                      name: text.series,
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.5,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (state.listSeriesMovie?.length ?? 0) >= 9
                          ? 9
                          : (state.listSeriesMovie?.length ?? 0),
                      itemBuilder: (context, index) {
                        return CommomMovieWidget(
                          items: state.listSeriesMovie?[index] ?? DataItems(),
                          onPress: () => _navigateDetailScreen(
                            state.listSeriesMovie?[index] ?? DataItems(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TitleWidget(
                      type: typeCartoonMovie,
                      title: text.cartoon,
                      name: text.cartoon,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SingleMovieWidget(
                            items: state.listCartoon?[index] ?? DataItems(),
                            onPress: () => _navigateDetailScreen(
                              state.listCartoon?[index] ?? DataItems(),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 16,
                        ),
                        itemCount: (state.listCartoon?.length ?? 0) >= 7
                            ? 10
                            : (state.listCartoon?.length ?? 0),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is HomeLoadErr) {
              return const Center(
                child: Text('err'),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  _navigateDetailScreen(DataItems items) {
    Navigator.of(context).pushNamed(
      RouteName.detail,
      arguments: items.slug,
    );
  }

  _navigateSearchScreen() {
    Navigator.of(context).pushNamed(
      RouteName.search,
    );
  }
}
