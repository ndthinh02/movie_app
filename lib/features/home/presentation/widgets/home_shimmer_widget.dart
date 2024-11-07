import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({super.key});

  Widget _buildHorizontalShimmerRow(double width, double height, {int count = 3}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          count,
              (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLine(double width) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: width,
      height: 10,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHorizontalShimmerRow(300, 300),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShimmerLine(120),
                  _buildShimmerLine(80),
                ],
              ),
              const SizedBox(height: 30),
              _buildHorizontalShimmerRow(120, 180),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShimmerLine(120),
                  _buildShimmerLine(80),
                ],
              ),
              const SizedBox(height: 30),
              _buildHorizontalShimmerRow(120, 180),
            ],
          ),
        ),
      ),
    );
  }
}