
import 'package:flutter/material.dart';

import 'status.dart';
import 'status_handler.dart';
import 'multiple_status_config.dart';
import 'status_widget_provider.dart';


///
/// @author LiuHe
/// @created at 2020/10/21 13:11

class StatusWidgetHelper {

  StatusWidgetHelper({
    this.retryingCallback,
    this.widgetProvider,
  }) {

    handler = StatusHandler(this);

    if (widgetProvider == null) {
      widgetProvider = MultipleStatusConfig.instance.getWidgetProvider();
    }

    if (widgetProvider == null) {
      return;
    }

    MultipleStatusConfig config = MultipleStatusConfig.instance;

    if (widgetProvider.getLoadingWidget != null) {
      /// 局部配置Widget
      loadingWidget = widgetProvider.getLoadingWidget(handler);
    } else {
      /// 全局配置Widget
      loadingWidget = config.getWidgetProvider().getLoadingWidget(handler);
    }

    if (widgetProvider.getEmptyWidget != null) {
      emptyWidget = widgetProvider.getEmptyWidget(handler);
    } else {
      emptyWidget = config.getWidgetProvider().getEmptyWidget(handler);
    }

    if (widgetProvider.getErrorWidget != null) {
      errorWidget = widgetProvider.getErrorWidget(handler);
    } else {
      errorWidget = config.getWidgetProvider().getErrorWidget(handler);
    }
  }

  /// 重试回调
  final VoidCallback retryingCallback;

  StatusWidgetProvider widgetProvider;

  Widget loadingWidget, emptyWidget, errorWidget;

  StatusHandler handler;

  Widget render(Status status) {
    return getStatusWidget(status);
  }

  Widget getStatusWidget(Status status) {
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