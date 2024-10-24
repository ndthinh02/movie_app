import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/home/data/models/new_movie_model.dart';

import '../../../../commom/widgets/cached_image.dart';

class NewMovieWidget extends StatelessWidget {
  const NewMovieWidget({
    super.key,
    required this.items,
  });

  //movie
  final List<Items> items;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: CarouselSlider.builder(
                itemCount: items.length,
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  return AppCacheImage(
                    imageUrl: items[index].posterUrl ?? '',
                    boxFit: BoxFit.cover,
                    width: size.width,
                    radius: 16,
                  );
                },
                options: CarouselOptions(
                  height: 300,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
