import 'package:flutter/material.dart';

import 'status.dart';
import 'status_controller.dart';
import 'status_widget_helper.dart';
import 'status_widget_provider.dart';


///
/// 多状态加载布局
/// 可全局或局部配置状态布局
/// 局部优先级大于全局
/// @author LiuHe
/// @created at 2021/1/25 10:30

class MultipleStatusWidget extends StatefulWidget {

  MultipleStatusWidget({
    required this.child,
    this.controller,
    this.retryingCallback,
    this.widgetProvider,
  });

  final Widget child;
  final StatusController? controller;
  final VoidCallback? retryingCallback;

  final StatusWidgetProvider? widgetProvider;

  @override
  State<StatefulWidget> createState() {
    return _MultipleStatusWidgetState(
        controller,
        retryingCallback,
        widgetProvider
    );
  }
}

class _MultipleStatusWidgetState extends State<MultipleStatusWidget> {

  _MultipleStatusWidgetState(
      controller,
      this.retryingCallback,
      this.widgetProvider
  ) {
    if (controller != null) {
      status = controller.getStatus();
      controller.setStatusChangedCallback(statusChanged);
    }
  }

  Status? status;
  StatusWidgetHelper? statusWidgetHelper;

  /// 重试回调
  final VoidCallback? retryingCallback;

  StatusWidgetProvider? widgetProvider;

  @override
  void initState() {
    statusWidgetHelper = StatusWidgetHelper(
      context: context,
      retryingCallback: retryingCallback,
      widgetProvider: widgetProvider,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    return Container(
//      child: (status != null && status != Status.FINISH) ? statusWidgetHelper.render(status) : widget.child,
//    );

    return LayoutBuilder(
        builder: (context, constraint) {
          return Stack(
            fit: constraint.maxHeight != double.infinity ? StackFit.expand : StackFit.loose,
            children: <Widget>[
              widget.child,
              if (status != null && status != Status.FINISH)
                statusWidgetHelper?.render(status!) ?? Container()
            ],
          );
        }
    );

  }

  /// 状态改变
  void statusChanged(Status status) {
    setState(() {
      this.status = status;
    });
  }

}