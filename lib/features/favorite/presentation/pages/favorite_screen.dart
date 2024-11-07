import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/commom/widgets/indicator.dart';
import 'package:movie_app/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:movie_app/features/favorite/presentation/widgets/favorite_items.dart';
import 'package:movie_app/route/route_name.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavoriteBloc>().add(GetListFavorite());
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is LoadListFav) {
            return const Center(
              child: IndicatorCommom(),
            );
          }
          if (state is LoadListFavSuccess) {
            return state.list?.isEmpty == true
                ? Center(
                    child: Text(
                      'Your Favorite is empty',
                      style: text.headlineSmall,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      itemCount: state.list?.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 8.0,
                      ),
                      itemBuilder: (context, index) {
                        return FavoriteItem(
                          nameMov: state.list?[index].nameMovie,
                          urlImage: state.list?[index].urlImage,
                          onPress: () {
                            Navigator.of(context).pushNamed(
                              RouteName.detail,
                              arguments: state.list?[index].slugMovie,
                            );
                          },
                        );
                      },
                    ),
                  );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
