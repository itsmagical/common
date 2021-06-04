
import 'status_widget_provider.dart';

/// 状态加载配置
class MultipleStatusConfig {

  MultipleStatusConfig._constructor();

  static final MultipleStatusConfig _instance = MultipleStatusConfig._constructor();

  static MultipleStatusConfig get instance {
    return _instance;
  }

  /// 状态布局Provider
  StatusWidgetProvider _provider;

  void setStatusWidgetProvider(StatusWidgetProvider provider) {
    _provider = provider;
  }

  StatusWidgetProvider getWidgetProvider() {
    return _provider;
  }

}