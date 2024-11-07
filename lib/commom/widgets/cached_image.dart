import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/commom/widgets/indicator.dart';
import 'package:movie_app/core/constant/constants.dart';

class AppCacheImage extends StatelessWidget {
  const AppCacheImage({
    super.key,
    this.height,
    this.width,
    required this.imageUrl,
    this.radius,
    this.boxFit,
  });

  final double? width;
  final double? height;
  final String imageUrl;
  final double? radius;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: SizedBox(
        width: width,
        height: height,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: boxFit,
          errorWidget: (context, url, error) => Image.network(defaultImg),
          placeholder: (context, url) => const IndicatorCommom(),
        ),
      ),
    );
  }
}
