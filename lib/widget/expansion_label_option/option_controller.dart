import 'package:flutter/cupertino.dart';

class OptionController {

  VoidCallback _setStateCallback;
  VoidCallback _resetOptionedIndexCallback;

  void setStateCallback(VoidCallback callback) {
    _setStateCallback = callback;
  }

  void setOptionedIndexCallback(VoidCallback callback) {
    _resetOptionedIndexCallback = callback;
  }


  /// 重置
  void reset() {
    _resetOptionedIndexCallback();
    _setStateCallback();
  }

}
