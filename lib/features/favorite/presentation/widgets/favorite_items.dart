import 'package:flutter/material.dart';
import 'package:movie_app/commom/widgets/cached_image.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    super.key,
    this.nameMov,
    this.urlImage,
    required this.onPress,
  });

  final String? urlImage;
  final String? nameMov;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          AppCacheImage(
            height: 160,
           radius: 10,
            boxFit: BoxFit.cover,
            imageUrl: '$urlImage',
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 100,
            child: Text(
              nameMov ?? '',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: text.headlineSmall,
            ),
          )
        ],
      ),
    );
  }
}
