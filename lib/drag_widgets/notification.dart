/// Created by RongCheng on 2022/7/26.

import 'package:flutter/material.dart';

// 自定义通知
// 通知冒泡来分发通知，通知会沿着当前节点向上传递，所有父节点都可以通过NotificationListener来监听通知，
// 通知冒泡和用户触摸事件冒泡是相似的，但有一点不同：通知冒泡可以中止，但用户触摸事件不行（NotificationListener return true：中止 ）

// 开始拖拽
class DragOnPanStartNotification extends Notification {
  final DragStartDetails details;
  const DragOnPanStartNotification(this.details);
}
// 拖拽更新中
class DragOnPanUpdateNotification extends Notification {
  final DragUpdateDetails details;
  const DragOnPanUpdateNotification(this.details);
}
// 拖拽结束
class DragOnPanEndNotification extends Notification {
  final DragEndDetails details;
  const DragOnPanEndNotification(this.details);
}
// 拖拽取消
class DragOnPanCancelNotification extends Notification {
  const DragOnPanCancelNotification();
}
// 单击通知，单击直接pop
class DragOnTapNotification extends Notification {
  const DragOnTapNotification();
}
