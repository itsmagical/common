import 'package:flutter/material.dart';

import 'status.dart';
import 'status_controller.dart';
import 'status_widget_helper.dart';
import 'status_widget_provider.dart';

/// 多状态加载布局
/// 可全局或局部配置状态布局
/// 局部优先级大于全局
class MultipleStatusWidget extends StatefulWidget {

  MultipleStatusWidget({
    @required this.child,
    this.controller,
    this.retryingCallback,
    this.widgetProvider,
  });

  final Widget child;
  final StatusController controller;
  final VoidCallback retryingCallback;

  final StatusWidgetProvider widgetProvider;

  @override
  State<StatefulWidget> createState() {
    return _MultipleStatusWidgetState(
        child,
        controller,
        retryingCallback,
        widgetProvider
    );
  }
}

class _MultipleStatusWidgetState extends State<MultipleStatusWidget> {

  _MultipleStatusWidgetState(
      this.child,
      controller,
      retryingCallback,
      widgetProvider
  ) {
    if (controller != null) {
      status = controller.getStatus();
      controller.setStatusChangedCallback(statusChanged);
    }
    statusWidgetHelper = StatusWidgetHelper(
      retryingCallback: retryingCallback,
      widgetProvider: widgetProvider,
    );
  }

  final Widget child;
  Status status;
  StatusWidgetHelper statusWidgetHelper;

  @override
  Widget build(BuildContext context) {
//    return Container(
//      child: (status != null && status != Status.FINISH) ? statusWidgetHelper.render(status) : widget.child,
//    );

    return Stack(
      children: <Widget>[
        child,
        if (status != null && status != Status.FINISH)
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: statusWidgetHelper.render(status),
          )
      ],
    );

  }

  /// 状态改变
  void statusChanged(Status status) {
    setState(() {
      this.status = status;
    });
  }

}