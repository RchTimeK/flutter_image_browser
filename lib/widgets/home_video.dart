/// Created by RongCheng on 2022/7/27.

import 'package:flutter/material.dart';
import 'package:flutter_image_browser/drag_widgets/drag_gesture_page_route.dart';
import 'package:flutter_image_browser/page/video_page.dart';
import 'package:video_player/video_player.dart';
/// ------------------ 视频 ------------------
class HomeVideoPage extends StatefulWidget {
  const HomeVideoPage({Key? key}) : super(key: key);

  @override
  State<HomeVideoPage> createState() => _HomeVideoPageState();
}

class _HomeVideoPageState extends State<HomeVideoPage> {

  final String videoUrl = "https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4";
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(videoUrl);
    await _videoPlayerController.initialize();
    if(!mounted) return;
    setState(() {});
    _videoPlayerController.play();
    _videoPlayerController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("视频"),),
      body: Hero(
        tag: "video",
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, DragGesturePageRoute(builder: (context) {
              return VideoPage(videoPlayerController: _videoPlayerController);
            },),);
          },
          child: SizedBox(
            width: 300,
            child: _videoPlayerController.value.isInitialized ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            ) : const SizedBox(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    super.dispose();
  }
}
