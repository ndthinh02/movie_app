import 'package:flutter/material.dart';
import 'package:movie_app/commom/widgets/cached_image.dart';
import 'package:movie_app/features/home/data/models/commom_movie_model.dart';

class MoreItemWidget extends StatelessWidget {
  const MoreItemWidget({
    super.key,
    required this.item,
    required this.onPress,
  });

  final DataItems item;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            AppCacheImage(
              imageUrl: 'https://phimimg.com/${item.posterUrl}',
              radius: 16,
              width: 120,
              height: 180,
              boxFit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 100,
              child: Text(
                item.name ?? '',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: text.headlineSmall,
              ),
            )
          ],
        ),
      ),
    );
  }
}
