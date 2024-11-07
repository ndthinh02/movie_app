import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/commom/bloc/language/language_bloc.dart';
import 'package:movie_app/commom/extensions/language_enum.dart';
import 'package:movie_app/features/setting/presentation/widgets/language_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../commom/share_preferences/app_share_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int _selectedIndex = -1;

  Future<void> loadLanguage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final intLanguage = pref.getInt(AppSharePreferences.keyLanguage);

    setState(() {
      _selectedIndex = intLanguage ?? 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLanguage();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          text.language,
        ),
      ),
      body: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return Column(
            children: [
              ...LanguageEnum.values.asMap().entries.map(
                (entry) {
                  int index = entry.key;
                  LanguageEnum e = entry.value;

                  return LanguageWidget(
                    title: e.title(),
                    icon: e.icon(),
                    index: index,
                    selectedIndex: _selectedIndex,
                    onPress: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      context
                          .read<LanguageBloc>()
                          .add(ChooseLanguage(index: index));
                    },
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
