/// Created by RongCheng on 2022/7/26.
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_image_browser/drag_widgets/notification.dart';
class DragGestureAnimation extends StatefulWidget {
  const DragGestureAnimation({
    Key? key,
    required this.child,
    required this.pushAnimationController,
    required this.popAnimationController,
  }) : super(key: key);
  final Widget child;
  final AnimationController pushAnimationController;
  final AnimationController popAnimationController;
  @override
  State<DragGestureAnimation> createState() => _DragGestureAnimationState();

}

class _DragGestureAnimationState extends State<DragGestureAnimation> with SingleTickerProviderStateMixin{
  // 缩放
  final ValueNotifier<double> _scaleNotifier = ValueNotifier<double>(1.0);
  // 位置
  final ValueNotifier<Offset> _offsetNotifier = ValueNotifier<Offset>(Offset.zero);
  // 高度中心点
  final double centerY = MediaQueryData.fromWindow(window).size.height *0.5;
  // 缩放的比例，若_scaleNotifier.value = 1- _offsetNotifier.value.dy).abs() / centerY，拖拽到接近底部后，图片会接近缩小0。
  final double  _scaleConst = 0.5;
  // 拖拽的有效距离，达到这个距离，page会直接pop
  final double _dragY = 100;
  // 重置动画的控制器，拖拽距离不足时，动画返回原来的位置
  late AnimationController _resetAnimationController;
  // 重置动画
  late Animation _resetAnimation;
  // 记录最后一次缩放值
  double _resetScale = 0;
  // 记录最后一次位置值
  Offset _resetOffset = Offset.zero;
  // 记录最后一次动画位置
  double _resetAnimationBound = 0;

  @override
  void initState() {
    super.initState();
    _resetAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        _scaleNotifier.value = _resetAnimation.value * (1 - _resetScale) + _resetScale;
        widget.pushAnimationController.value = _resetAnimation.value * (1 - _resetAnimationBound) + _resetAnimationBound;
        double dx = _resetAnimation.value * (1 - _resetOffset.dx) + _resetOffset.dx;
        double dy = _resetAnimation.value * (1 - _resetOffset.dy) + _resetOffset.dy;
        _offsetNotifier.value = Offset(dx, dy);
      });
    _resetAnimation = CurvedAnimation(parent: _resetAnimationController, curve: Curves.easeOut,);
  }

  @override
  Widget build(BuildContext context) {
    // 监听，只处理DragNotification类型的通知
    return NotificationListener(
      onNotification: (notification) {
        if (notification is DragOnPanStartNotification) {
          _onPanStart(notification.details);
        } else if (notification is DragOnPanUpdateNotification) {
          _onPanUpdate(notification.details);
        } else if (notification is DragOnPanEndNotification) {
          _onPanEnd(notification.details);
        } else if (notification is DragOnPanCancelNotification) {
          _onPanCancel();
        }else if (notification is DragOnTapNotification) {
          _onTap();
        }
        return false;
      },
      child: ValueListenableBuilder<Offset>(
        valueListenable: _offsetNotifier,
        builder: (context, offset, child) {
          return Transform.translate( // 矩阵变换
            offset: offset,
            child: ValueListenableBuilder<double>(
              valueListenable: _scaleNotifier,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: RepaintBoundary(
                    child: widget.child,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // 拖拽开始
  void _onPanStart(DragStartDetails details) {}

  // 拖拽中
  void _onPanUpdate(DragUpdateDetails details) {
    // 更新位置
    _offsetNotifier.value += details.delta;
    // 更新大小缩放
    _scaleNotifier.value = 1 - ((_offsetNotifier.value.dy).abs() / centerY * _scaleConst);
    // 背景渐变
    widget.pushAnimationController.value = 1 - ((_offsetNotifier.value.dy).abs() / centerY );
    // pop.value = push.value，动画衔接，更流畅
    widget.popAnimationController.value = widget.pushAnimationController.value;
  }

  // 拖拽结束
  void _onPanEnd(DragEndDetails details) {
    // 上下拖拽距离超过有效距离后，触发退出
    if((_offsetNotifier.value.dy).abs() > _dragY){
      _pop();
    }else{ // 不足有效距离，回到原处，开启重置动画
      _resetScale = _scaleNotifier.value;
      _resetOffset = _offsetNotifier.value;
      _resetAnimationBound = widget.pushAnimationController.value;
      _resetAnimationController.forward(from: 0);
    }
  }

  // 取消拖拽
  void _onPanCancel() {}

  // 单击
  void _onTap(){
    _pop();
  }

  // 返货
  void _pop() {
    widget.pushAnimationController.value = 1;
    widget.popAnimationController.animateTo(0, duration: const Duration(milliseconds: 300));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _resetAnimationController.dispose();
    super.dispose();
  }
}
