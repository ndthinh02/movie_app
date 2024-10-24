import 'package:flutter/material.dart';
import 'package:movie_app/commom/widgets/cached_image.dart';
import 'package:movie_app/core/constant/constants.dart';
import 'package:movie_app/features/home/data/models/commom_movie_model.dart';

class SingleMovieWidget extends StatelessWidget {
  const SingleMovieWidget({
    super.key,
    required this.items,
  });

  final DataSingleItems items;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Text(
          items.name ?? '',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
