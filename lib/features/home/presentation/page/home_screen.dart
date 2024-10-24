import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constant/constants.dart';
import 'package:movie_app/features/home/data/models/commom_movie_model.dart';
import 'package:movie_app/features/home/data/models/series_model.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/features/home/presentation/widgets/new_movie_widget.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/features/home/presentation/widgets/title_widget.dart';
import '../widgets/series_movie_widget.dart';
import '../widgets/single_movie_widget.dart';
import 'package:lottie/lottie.dart';

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
    context.read<HomeBloc>().add(LoadNewMovieEvent());
    context.read<HomeBloc>().add(LoadCommomMovieEvent(10));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeMovieInitial) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lotties/loading.json',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              );
            }
            if (state is HomeLoadSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewMovieWidget(
                      items: state.listItems ?? [],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TitleWidget(
                      title: text.single_movie,
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
                            items: state.listSingleMovie?[index] ??
                                DataSingleItems(),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 20,
                        ),
                        itemCount: state.listSingleMovie?.length ?? 0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TitleWidget(
                      title: text.series,
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return SeriesMovieWidget(
                          items: state.listSeriesMovie?[index] ??
                              DataSeriesItems(),
                        );
                      },
                    ),
                    TitleWidget(
                      title: text.cartoon,
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
                            items: state.listCartoon?[index] ??
                                DataSingleItems(),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 20,
                        ),
                        itemCount: state.listCartoon?.length ?? 0,
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
}
