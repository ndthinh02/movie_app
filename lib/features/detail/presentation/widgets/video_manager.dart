import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/config/colors/app_colors.dart';
import 'package:movie_app/di.dart';
import 'package:video_player/video_player.dart';

import '../../../../route/route_name.dart';
import '../../../favorite/domain/entity/favorite_entity.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../home/presentation/widgets/single_movie_widget.dart';
import '../../../home/presentation/widgets/title_widget.dart';
import '../../domain/entities/detail_entity.dart';
import '../bloc/detail_bloc.dart';

class VideoManager extends StatefulWidget {
  final String urlVideo;
  final DetailEntity? items;

  const VideoManager({
    super.key,
    required this.urlVideo,
    required this.items,
  });

  @override
  _VideoManagerState createState() => _VideoManagerState();
}

class _VideoManagerState extends State<VideoManager> {
  late FlickManager flickManager;
  bool _isFav = false;
  int selectedIndex = 0;
  final bloc = getIt<DetailBloc>();

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.urlVideo),
      ),
    );
    _getFavoriteStatus();
  }

  Future<void> _getFavoriteStatus() async {
    final favorite = await FirebaseFirestore.instance
        .collection("Favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Favorite Movie")
        .doc(widget.items?.movie?.name ?? '')
        .get();
    if (mounted) {
      setState(
        () => _isFav = favorite.get("isFav"),
      );
    }
  }

  @override
  void dispose() {
    flickManager.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Column(
      children: [
        FlickVideoPlayer(flickManager: flickManager),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildTitleAndFavoriteIcon(context),
              _buildEpisodeList(),
              const SizedBox(height: 10),
              _buildCategoryList(),
              const SizedBox(height: 30),
              _buildMovieDetails(text),
              const SizedBox(height: 30),
              _buildDescription(text),
              const SizedBox(height: 10),
              _buildRelatedMovies(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTitleAndFavoriteIcon(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.items?.movie?.name ?? '',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Spacer(),
        // IconButton(
        //   onPressed: () async {
        //     // final tasks = await FlutterDownloader.loadTasks();
        //     //
        //     // await FlutterDownloader.enqueue(
        //     //   url: widget.urlVideo,
        //     //   savedDir: '/storage/emulated/0/Download',
        //     //   showNotification: true,
        //     //   openFileFromNotification: true,
        //     //   saveInPublicStorage: true,
        //     //   fileName: widget.items?.movie?.name,
        //     // );
        //     FileDownloader.downloadFile(
        //         url: widget.urlVideo,
        //         name: widget.items?.movie?.name,
        //         onProgress: (String? fileName, double progress) {
        //           print(progress);
        //         },
        //         onDownloadCompleted: (String path) {
        //           print('FILE DOWNLOADED TO PATH: $path');
        //         },
        //         onDownloadError: (String error) {
        //           print('DOWNLOAD ERROR: $error');
        //         });
        //   },
        //   icon: const Icon(
        //     Icons.download_outlined,
        //   ),
        // ),
        const SizedBox(
          width: 10,
        ),
        BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                setState(() => _isFav = !_isFav);
                context.read<DetailBloc>().add(
                      AddOrRemoveFav(
                        isFav: _isFav,
                        favoriteEntity: FavoriteEntity(
                          urlImage: widget.items?.movie?.posterUrl,
                          slugMovie: widget.items?.movie?.slug ?? '',
                          nameMovie: widget.items?.movie?.name ?? '',
                        ),
                      ),
                    );
              },
              icon: Icon(
                _isFav ? Icons.favorite : Icons.favorite_border,
                color: _isFav ? Colors.red : null,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEpisodeList() {
    final episodes = widget.items?.episodes?[0].serverData ?? [];
    return episodes.length > 1
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const TitleWidget(
                title: "Episodes",
                fontSize: 16,
                fontSizeSub: 12,
                isDetail: true,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 45,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: episodes.length,
                  itemBuilder: (context, index) =>
                      _buildEpisodeButton(index, episodes[index].linkM3u8),
                  separatorBuilder: (context, _) => const SizedBox(width: 10),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _buildEpisodeButton(int index, String? url) {
    return InkWell(
      onTap: selectedIndex == index
          ? null
          : () {
              setState(() => selectedIndex = index);
              flickManager.handleChangeVideo(VideoPlayerController.networkUrl(
                Uri.parse(url ?? ''),
              ));
            },
      child: Container(
        width: 40,
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? AppColors.colorGreen.withOpacity(0.5)
              : Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text('${index + 1}',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    final categories = widget.items?.movie?.category ?? [];
    return Wrap(
      children: categories.map((category) {
        return Container(
          height: 40,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(right: 10, top: 10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(category.name ?? '',
              style: Theme.of(context).textTheme.headlineSmall),
        );
      }).toList(),
    );
  }

  Widget _buildMovieDetails(AppLocalizations text) {
    final movie = widget.items?.movie;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDetailColumn(text.length, movie?.time),
        _buildDetailColumn(text.language, movie?.country?[0].name),
        _buildDetailColumn(text.quality, movie?.quality),
      ],
    );
  }

  Widget _buildDetailColumn(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        Text(
          value ?? '',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildDescription(AppLocalizations text) {
    final content =
        widget.items?.movie?.content?.replaceAll('&quot;', '') ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text.description,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 10),
        AnimatedReadMoreText(
          content,
          maxLines: 3,
          readMoreText: '... ${text.expand}',
          readLessText: text.collapse,
          textStyle: Theme.of(context).textTheme.headlineSmall,
          buttonTextStyle: TextStyle(
              fontSize: 14,
              color: AppColors.colorGreen,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildRelatedMovies() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadSuccess) {
          final movies = state.listSingleMovie ?? [];
          return movies.isNotEmpty
              ? SizedBox(
                  height: 240,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length >= 10 ? 10 : movies.length,
                    itemBuilder: (context, index) => SingleMovieWidget(
                      items: movies[index],
                      onPress: () => Navigator.of(context).pushNamed(
                        RouteName.detail,
                        arguments: movies[index].slug,
                      ),
                    ),
                    separatorBuilder: (context, _) => const SizedBox(width: 16),
                  ),
                )
              : const SizedBox.shrink();
        }
        return const SizedBox();
      },
    );
  }
}
