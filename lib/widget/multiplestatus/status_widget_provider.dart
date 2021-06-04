import 'package:flutter/material.dart';

import 'multiple_status_constant.dart';

/// 状态Widget Provider
class StatusWidgetProvider {

  StatusWidgetProvider({
    this.getLoadingWidget,
    this.getEmptyWidget,
    this.getErrorWidget
  });

  WidgetProvider<Widget> getLoadingWidget;

  WidgetProvider<Widget> getEmptyWidget;

  WidgetProvider<Widget> getErrorWidget;

}