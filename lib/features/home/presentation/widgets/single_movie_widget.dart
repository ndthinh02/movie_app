import 'package:flutter/material.dart';
import 'package:movie_app/commom/widgets/cached_image.dart';
import 'package:movie_app/core/constant/constants.dart';
import 'package:movie_app/features/home/data/models/commom_movie_model.dart';

class SingleMovieWidget extends StatelessWidget {
  const SingleMovieWidget({
    super.key,
    required this.items,
    required this.onPress,
  });

  final DataItems items;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          AppCacheImage(
            width: 120,
            height: 180,
            radius: 16,
            boxFit: BoxFit.cover,
            imageUrl: '$baseUrlImage${items.posterUrl}' ?? '',
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 100,
            child: Text(
              items.name ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: themeText.headlineSmall,
            ),
          )
        ],
      ),
    );
  }
}
