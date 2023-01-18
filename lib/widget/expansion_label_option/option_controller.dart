import 'package:flutter/cupertino.dart';

/// 可折叠的标签选择器 controller
/// 设置默认选中位置，以及
class OptionController {

  OptionController({
    int initOptionedIndex
  }) {
    /// 默认选中的位置
    optionedIndex = initOptionedIndex;
  }

  /// 选中label位置
  int optionedIndex;

  VoidCallback _setStateCallback;
  VoidCallback _resetOptionedIndexCallback;

  /// 设置选中位置
  setOptionedIndex(int index) {
    optionedIndex = index;
    _reset();
  }

  /// 重置
  void _reset() {
    if (_resetOptionedIndexCallback != null) {
      _resetOptionedIndexCallback();
    }
    if (_setStateCallback != null) {
      _setStateCallback();
    }
  }

  /// 内部调用
  void setStateCallback(VoidCallback callback) {
    _setStateCallback = callback;
  }

  /// 内部调用
  void setOptionedIndexCallback(VoidCallback callback) {
    _resetOptionedIndexCallback = callback;
  }

}
