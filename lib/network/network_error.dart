import 'dart:io';

import 'package:dio/dio.dart';

class NetWorError {

  static String getErrorDesc(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return '连接超时, 请稍后再试';
      case DioExceptionType.receiveTimeout:
        return '接收数据超时, 请检查网络';
      case DioExceptionType.connectionError:
        return '链接错误，请稍后再试';
      case DioExceptionType.badCertificate:
        return '证书错误';
      case DioExceptionType.badResponse:
        return '响应状态码错误';
      case DioExceptionType.sendTimeout:
        return 'url发送超时';
      case DioExceptionType.cancel:
        return '请求已取消';
      case DioExceptionType.unknown:
        // if (dioError.error is SocketException) {
        //   return '网络错误，请检查网络';
        // }
        return '未知错误';
    }
    return '未知错误';
  }

}