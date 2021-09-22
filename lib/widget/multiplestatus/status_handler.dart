
import 'status_widget_helper.dart';

class StatusHandler {

  StatusWidgetHelper helper;

  StatusHandler(this.helper);

  /// 重试
  onRetryingCommand() {
    if (helper.retryingCallback != null) {
      helper.retryingCallback();
    }
  }

}