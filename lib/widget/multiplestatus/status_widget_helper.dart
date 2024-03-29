
import 'package:flutter/material.dart';

import 'multiple_status_config.dart';
import 'status.dart';
import 'status_handler.dart';
import 'status_widget_provider.dart';


///
/// @author LiuHe
/// @created at 2020/10/21 13:11

class StatusWidgetHelper {

  StatusWidgetHelper({
    required this.context,
    this.retryingCallback,
    StatusWidgetProvider? widgetProvider,
  }) {

    handler = StatusHandler(this);

    MultipleStatusConfig config = MultipleStatusConfig.instance;

    /// 未设置局部Widget则使用全局配置Widget
    if (widgetProvider == null) {
      widgetProvider = config.getWidgetProvider();
    }

    if (widgetProvider.getLoadingWidget != null) {
      /// 局部配置Widget
      loadingWidget = widgetProvider.getLoadingWidget!(handler, context);
    } else {
      /// 全局配置Widget
      loadingWidget = config.getWidgetProvider().getLoadingWidget!(handler, context);
    }

    if (widgetProvider.getEmptyWidget != null) {
      emptyWidget = widgetProvider.getEmptyWidget!(handler, context);
    } else {
      emptyWidget = config.getWidgetProvider().getEmptyWidget!(handler, context);
    }

    if (widgetProvider.getErrorWidget != null) {
      errorWidget = widgetProvider.getErrorWidget!(handler, context);
    } else {
      errorWidget = config.getWidgetProvider().getErrorWidget!(handler, context);
    }
  }

  BuildContext context;

  /// 重试回调
  final VoidCallback? retryingCallback;

  late Widget loadingWidget, emptyWidget, errorWidget;

  late StatusHandler handler;

  dynamic focusStatusView;

  Widget? render(Status status) {
    return getStatusWidget(status);
  }

  Widget? getStatusWidget(Status status) {
    switch (status) {
      case Status.LOADING: {
        return loadingWidget;
      }
      case Status.EMPTY: {
        return emptyWidget;
      }
      case Status.ERROR: {
        return errorWidget;
      }
      case Status.FINISH: {
        return null;
      }
      default :
        return null;
    }

  }

}