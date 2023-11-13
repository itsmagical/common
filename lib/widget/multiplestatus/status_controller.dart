import 'package:flutter/material.dart';
import 'status.dart';

/// 状态控制
class StatusController {

  Status? _status;

  ValueChanged<Status>? _statusChangedCallback;

  void setStatusChangedCallback(ValueChanged<Status> callback) {
    _statusChangedCallback = callback;
  }

  /// 显示加载中
  void setLoading() {
    _statusChanged(Status.LOADING);
  }

  /// 显示空数据
  void setEmpty() {
    _statusChanged(Status.EMPTY);
  }

  /// 显示错误
  void setError() {
    _statusChanged(Status.ERROR);
  }

  /// 完成 显示内容布局
  void finish() {
    _statusChanged(Status.FINISH);
  }

  /// 完成 根据Value判断显示状态
  void finishValue(var value) {
    if (value == null) {
      setEmpty();
      return;
    }

    if (value is Iterable) {
      if (value.length > 0) {
        finish();
      } else {
        setEmpty();
      }
      return;
    }

    finish();
  }

  void _statusChanged(Status status) {
    _status = status;
    if (_statusChangedCallback != null) {
      _statusChangedCallback!(status);
    }
  }

  Status? getStatus() {
    return _status;
  }

}