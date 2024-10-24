import 'package:flutter/material.dart';
import 'package:movie_app/features/home/data/models/series_model.dart';

import '../../../../commom/widgets/cached_image.dart';
import '../../../../core/constant/constants.dart';
import '../../data/models/commom_movie_model.dart';

class SeriesMovieWidget extends StatelessWidget {
  const SeriesMovieWidget({
    super.key,
    required this.items,
  });

  final DataSeriesItems items;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCacheImage(
          width: 120,
          height: 140,
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
