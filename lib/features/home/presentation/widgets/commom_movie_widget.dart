import 'package:flutter/material.dart';

import '../../../../commom/widgets/cached_image.dart';
import '../../../../core/constant/constants.dart';
import '../../data/models/commom_movie_model.dart';

class CommomMovieWidget extends StatelessWidget {
  const CommomMovieWidget({
    super.key,
    required this.items,
    this.heightImg,
    this.widthImg,
    required this.onPress,
  });

  final DataItems items;
  final double? widthImg;
  final double? heightImg;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          AppCacheImage(
            width: widthImg ?? 120,
            height: heightImg ?? 180,
            radius: 16,
            boxFit: BoxFit.cover,
            imageUrl: '$baseUrlImage${items.posterUrl}' ?? '',
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 150,
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
