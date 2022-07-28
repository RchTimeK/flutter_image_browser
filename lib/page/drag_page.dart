/// Created by RongCheng on 2022/7/26.

import 'package:flutter/material.dart';
import 'package:flutter_image_browser/drag_widgets/drag_gesture_detector.dart';
class DragPage extends StatelessWidget {
  const DragPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: DragGestureDetector(
          child: Hero(
            tag: "tag1",
            child: Image.asset("assets/images/yy.png"),
          ),
        ),
      ),
    );
  }
}
