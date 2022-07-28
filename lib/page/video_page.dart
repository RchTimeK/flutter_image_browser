/// Created by RongCheng on 2022/7/27.

import 'package:flutter/material.dart';
import 'package:flutter_image_browser/drag_widgets/drag_gesture_detector.dart';
import 'package:video_player/video_player.dart';
class VideoPage extends StatelessWidget {
  const VideoPage({Key? key,required this.videoPlayerController}) : super(key: key);
  final VideoPlayerController videoPlayerController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: DragGestureDetector(
          child: Hero(
            tag: "video",
            transitionOnUserGestures: true,
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            )
          ),
        ),
      ),
    );
  }
}
