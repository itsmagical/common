library common;

import 'package:common/util/sp_util.dart';
import 'package:common/widget/multiplestatus/multiple_status_config.dart';
import 'package:common/widget/multiplestatus/status_widget/empty_status_widget.dart';
import 'package:common/widget/multiplestatus/status_widget/error_status_widget.dart';
import 'package:common/widget/multiplestatus/status_widget/loading_status_widget.dart';
import 'package:common/widget/multiplestatus/status_widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

export 'package:webview_flutter/webview_flutter.dart';
export 'package:permission_handler/permission_handler.dart';

/// 基本组件
/// 基本业务组件或业务组件都需要依赖此组件
/// @author LiuHe
/// @created at 2021/1/19 14:22

class Common {

  /// 初始化
  static Future init() async {
    initMultipleStatusWidget();
    initEasyRefresh();
    await SpUtil.instance.init();
  }

  /// 初始化多状态加载布局
  static void initMultipleStatusWidget() {
    MultipleStatusConfig.instance.setStatusWidgetProvider(
      StatusWidgetProvider(
        getLoadingWidget: (handler) => LoadingStatusWidget(),
        getEmptyWidget: (handler) => EmptyStatusWidget(),
        getErrorWidget: (handler)=> ErrorStatusWidget(handler),
      )
    );
  }

  /// 初始化EasyRefresh样式
  static void initEasyRefresh() {
    EasyRefresh.defaultHeader = ClassicalHeader(
        refreshText: "下拉刷新",
        refreshReadyText: "松开后开始刷新",
        refreshingText: "正在刷新...",
        refreshedText: "刷新完成",
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        infoText: '更新于 %T',
        infoColor: Colors.black87);
    EasyRefresh.defaultFooter = ClassicalFooter(
        loadText: "上拉加载更多",
        loadReadyText: "松开后开始加载",
        loadingText: "正在加载...",
        loadedText: "加载完成",
        noMoreText: "没有更多内容了",
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        infoText: '更新于 %T',
        infoColor: Colors.black87);
  }

}
