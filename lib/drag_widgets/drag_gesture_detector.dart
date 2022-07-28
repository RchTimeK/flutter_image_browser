/// Created by RongCheng on 2022/7/26.

import 'package:flutter/material.dart';
import 'package:flutter_image_browser/drag_widgets/drag_gesture_animation.dart';
import 'package:flutter_image_browser/drag_widgets/notification.dart';
/// 拖拽的widget
class DragGestureDetector extends StatelessWidget {
  const DragGestureDetector({
    Key? key,
    required this.child,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onTap,
  }) : super(key: key);
  final Widget child;
  final Function? onPanStart;
  final Function? onPanUpdate;
  final Function? onPanEnd;
  final Function? onPanCancel;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (DragStartDetails details){
        DragOnPanStartNotification(details).dispatch(context);
        onPanStart?.call();
      },
      onPanUpdate: (DragUpdateDetails details){
        DragOnPanUpdateNotification(details).dispatch(context);
        onPanUpdate?.call();
      },
      onPanEnd: (DragEndDetails details){
        DragOnPanEndNotification(details).dispatch(context);
        onPanEnd?.call();
      },
      onPanCancel: (){
        const DragOnPanCancelNotification().dispatch(context);
        onPanCancel?.call();
      },
      onTap: (){
        const DragOnTapNotification().dispatch(context);
        onTap?.call();
      },
      child: child,/// 只有[child]会被响应拖拽事件
    );
  }
}
