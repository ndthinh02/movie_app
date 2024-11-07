import 'package:flutter/material.dart';
import 'package:movie_app/commom/widgets/cached_image.dart';
import 'package:movie_app/features/home/data/models/commom_movie_model.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    super.key,
    required this.items,
    required this.onPress,
  });

  final DataItems items;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 140,
        margin: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCacheImage(
              width: 100,
              height: 140,
              boxFit: BoxFit.cover,
              radius: 16,
              imageUrl: 'https://phimimg.com/${items.posterUrl}' ?? '',
            ),
            const SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    items.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${items.year}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${items.quality}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
