/// Created by RongCheng on 2022/7/26.

import 'package:flutter/material.dart';
import 'package:flutter_image_browser/drag_widgets/drag_gesture_animation.dart';

/// 自定义路由动画
class DragGesturePageRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin {
  DragGesturePageRoute({
    required this.builder,
    RouteSettings? settings,
    this.maintainState = true,
  }) : super(settings: settings, fullscreenDialog: true);

  final WidgetBuilder builder;

  @override
  final bool maintainState;


  AnimationController? _pushAnimationController;
  AnimationController? _popAnimationController;

  @override
  Widget buildContent(BuildContext context) {
    return DragGestureAnimation( // DragGestureAnimation：计算和处理动画的widget
      pushAnimationController: _pushAnimationController!,
      popAnimationController: _popAnimationController!,
      child: builder(context),
    );
  }

  // 重写动画
  @override
  AnimationController createAnimationController() {
    if (_pushAnimationController == null) {
      _pushAnimationController = AnimationController(
        vsync: navigator!.overlay!,
        duration: transitionDuration,
        reverseDuration: transitionDuration,
      );
      _popAnimationController = AnimationController(
        vsync: navigator!.overlay!,
        duration: transitionDuration,
        reverseDuration: transitionDuration,
        value: 1,
      );
    }
    return _pushAnimationController!;
  }

  // 背景，添加淡入淡出的动画
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Stack(
      children: [
        FadeTransition(
          opacity: isActive ? _pushAnimationController! : _popAnimationController!,// 判断该路由是否在导航上，来使用不同的控制器
          child: Container(
            color: Colors.black,
          ),
        ),
        child,
      ],
    );
  }

  String? get title => null;
}