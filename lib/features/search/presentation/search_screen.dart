import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/commom/widgets/indicator.dart';
import 'package:movie_app/features/search/presentation/widget/search_item.dart';

import '../../../../route/route_name.dart';
import '../../../commom/debouncer/debouncer.dart';
import '../../home/data/models/commom_movie_model.dart';
import 'bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SearchBloc>().add(
          SearchListMovie(
            keyword: '',
            limit: 0,
          ),
        );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _controller.clear();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _textFiled(),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    if (state.isSearch == true) {
                      return const IndicatorCommom();
                    } else {
                      return const SizedBox.shrink();
                    }
                  }
                  if (state is SearchSuccess) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        (state.listSearch?.isEmpty ?? []) == true
                            ? Center(
                                child: Center(
                                  child: Text(
                                    text.movie_not_found,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return SearchItem(
                                    items:
                                        state.listSearch?[index] ?? DataItems(),
                                    onPress: () => _navigateDetailScreen(
                                        state.listSearch?[index] ??
                                            DataItems()),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 16,
                                ),
                                itemCount: (state.listSearch?.length ?? 0) >= 7
                                    ? 10
                                    : (state.listSearch?.length ?? 0),
                              ),
                      ],
                    );
                  }
                  if (state is SearchErr) {
                    return const Center(
                      child: Text(
                        'err',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      )),
    );
  }

  _navigateDetailScreen(DataItems items) {
    Navigator.of(context).pushNamed(
      RouteName.detail,
      arguments: items.slug,
    );
  }

  _textFiled() {
    final text = AppLocalizations.of(context)!;
    return TextField(
      controller: _controller,
      onChanged: (value) {
        _debouncer.run(() {
          context.read<SearchBloc>().add(
                SearchListMovie(
                  keyword: value,
                  limit: 10,
                ),
              );
        });
      },
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: text.search_for_title,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        suffixIcon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
