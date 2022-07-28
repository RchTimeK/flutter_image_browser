/// Created by RongCheng on 2022/7/27.

import 'package:flutter/material.dart';
import 'package:flutter_image_browser/drag_widgets/drag_gesture_detector.dart';
import 'package:flutter_image_browser/widgets/image_drag.dart';
class ImageBrowserPage extends StatefulWidget {
  const ImageBrowserPage({
    Key? key,
    required this.tags,
    required this.imagePaths,
    required this.index
  }) : super(key: key);
  final List<Object> tags;
  final List<String> imagePaths;
  final int index;
  @override
  State<ImageBrowserPage> createState() => _ImageBrowserPageState();
}

class _ImageBrowserPageState extends State<ImageBrowserPage> {

  late int _currentPage;
  late PageController _pageController;
  bool _visible = true;
  bool _isPop = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPage = widget.index;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Center(
            child: DragGestureDetector(
              onPanStart: _onPanStart,
              onPanEnd: _onPanEnd,
              child: Hero(
                  tag: widget.tags[_currentPage],
                  transitionOnUserGestures: true,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.tags.length,
                    itemBuilder: (ctx,index){
                      return Image.asset(widget.imagePaths[index]);
                    },
                    onPageChanged: (page){
                      if(page != _currentPage){
                        // 更新tag值
                        if(mounted){
                          setState(() {
                            _currentPage = page;
                          });
                        }
                      }
                    },
                  )
              ),
            ),
          ),
          Visibility(
            visible: _visible,
            child: Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                "${_currentPage+1}/${widget.tags.length}",
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),
              ),
            ),
          ),
          Visibility(
            visible: _visible,
            child: Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: (){
                  debugPrint("假装保存成功了！");
                },
                child: const Text(
                  "保存",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPanStart(){
    setState(() {
      _visible = false;
    });
  }
  void _onPanEnd(){
    setState(() {
      _visible = true;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }
}
