

import 'package:common/widget/multiplestatus/status_widget/empty_status_widget.dart';
import 'package:common/widget/multiplestatus/status_widget/error_status_widget.dart';
import 'package:common/widget/multiplestatus/status_widget/loading_status_widget.dart';

import 'status_widget_provider.dart';

/// 状态加载配置
class MultipleStatusConfig {

  MultipleStatusConfig._constructor() {
    /// 配置默认状态布局
    _provider = StatusWidgetProvider(
        getLoadingWidget: (handler, context) {
          return LoadingStatusWidget(context: context);
        },
        getErrorWidget: (handler, context) {
          return ErrorStatusWidget(handler);
        },
        getEmptyWidget: (handler, context) {
          return EmptyStatusWidget(handler);
        }
    );
  }

  static final MultipleStatusConfig _instance = MultipleStatusConfig._constructor();

  static MultipleStatusConfig get instance {
    return _instance;
  }

  /// 状态布局Provider
  late StatusWidgetProvider _provider;

  void setStatusWidgetProvider(StatusWidgetProvider provider) {
    _provider = provider;
  }

  StatusWidgetProvider getWidgetProvider() {
    return _provider;
  }

}