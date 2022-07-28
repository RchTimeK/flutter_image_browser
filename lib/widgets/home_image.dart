/// Created by RongCheng on 2022/7/27.

import 'package:flutter/material.dart';
import 'package:flutter_image_browser/drag_widgets/drag_gesture_page_route.dart';
import 'package:flutter_image_browser/page/drag_page.dart';
class HomeImagePage extends StatefulWidget {
  const HomeImagePage({Key? key}) : super(key: key);

  @override
  State<HomeImagePage> createState() => _HomeImagePageState();
}

class _HomeImagePageState extends State<HomeImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drag"),),
      body: Hero(
        tag: "tag1",
        child: GestureDetector(
          onTap: _onTap,
          child: Image.asset("assets/images/yy.png",width: 300,)
        ),
      )
    );
  }
  void _onTap(){
    Navigator.push(context, DragGesturePageRoute(builder: (context) {
      return const DragPage();
    }));
  }
}
