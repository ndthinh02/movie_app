import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/features/detail/presentation/bloc/detail_bloc.dart';

import '../../../../commom/widgets/indicator.dart';
import '../widgets/video_manager.dart';

class DetailScreen extends StatefulWidget {
  final String slugMovie;

  const DetailScreen({
    super.key,
    required this.slugMovie,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DetailBloc>().add(
          LoadDetailEvent(
            slugMovie: widget.slugMovie,
          ),
        );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailInitial) {
            return const Column(
              children: [
                IndicatorCommom(),
              ],
            );
          }
          if (state is DetailLoadSuccess) {
            final items = state.detail;
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    VideoManager(
                      urlVideo:
                          items?.episodes?[0].serverData?[0].linkM3u8 ?? '',
                      items: items,
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is DetailLoadErr) {
            return const Center(
              child: Text('err'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

}

