import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class VideoPlayerContainer extends StatefulWidget {
  const VideoPlayerContainer({super.key, required this.videoUrl});
  final String videoUrl;
  @override
  State<VideoPlayerContainer> createState() => _VideoPlayerContainerState();
}

class _VideoPlayerContainerState extends State<VideoPlayerContainer> {
  late CachedVideoPlayerPlusController videoPlayerPlusController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    videoPlayerPlusController = CachedVideoPlayerPlusController.network(
        widget.videoUrl)
      ..initialize().then((value) => videoPlayerPlusController.setVolume(1));
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedVideoPlayerPlus(videoPlayerPlusController),
          Align(
              child: IconButton(
            onPressed: () {
              if (isPlay) {
                videoPlayerPlusController.pause();
              } else {
                videoPlayerPlusController.play();
              }
              setState(() {
                isPlay = !isPlay;
              });
            },
            icon: Icon(isPlay ? Icons.pause_circle : Icons.play_circle),
            alignment: Alignment.center,
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerPlusController.dispose();
  }
}
