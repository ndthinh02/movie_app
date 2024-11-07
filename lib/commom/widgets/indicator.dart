import 'package:flutter/cupertino.dart';

class IndicatorCommom extends StatelessWidget {
  const IndicatorCommom({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 100),
        width: 80,
        height: 80,
        child: const CupertinoActivityIndicator(),
      ),
    );
  }
}
