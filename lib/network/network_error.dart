import 'dart:io';

import 'package:dio/dio.dart';

class NetWorError {

  static String getErrorDesc(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return '连接超时, 请稍后再试';
      case DioErrorType.SEND_TIMEOUT:
        return '请求超时, 请检查网络';
      case DioErrorType.RECEIVE_TIMEOUT:
        return '接收数据超时, 请检查网络';
      case DioErrorType.RESPONSE:
        return '响应状态错误';
      case DioErrorType.CANCEL:
        return '请求已取消';
      case DioErrorType.DEFAULT:
        if (dioError.error is SocketException) {
          return '网络错误，请检查网络';
        }

        return '未知错误';
    }

  }

}