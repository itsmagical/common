import 'dart:convert';

import 'package:common/util/log_util.dart';
import 'package:dio/dio.dart';


///
/// 网络请求Log拦截器
/// @author LiuHe
/// @created at 2021/9/9 10:02

class LoggingInterceptor extends Interceptor {

  @override
  Future onResponse(Response response) {

    try {
      RequestOptions request = response.request;

      Map<String, dynamic> headerMap = request.headers;

      String headers = '';

      headerMap.forEach((key, value) {
        headers += '$key: $value \n ';
      });

      LogUtil.d(
          '''
      -------------------headers----------------------------
      Entity:
        content-type: ${request.contentType}
      headers:
        $headers
      -------------------body----------------------------
      url:
        ${request.baseUrl + request.path}
      parameters:
        ${jsonEncode(request.data)}
      response:
        ${jsonEncode(response.data)}
      '''
      );
    } catch(error) {
      LogUtil.d('onResponse：log拦截器出现错误');
    }

    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    try {
      var request = err.request;
      LogUtil.d(
          '''
      url：
        ${request.baseUrl + request.path}
      parameters：
        ${jsonEncode(request.data)}
      errorMessage：
        ${err.message}
      
      '''
      );
    } catch(error) {
      LogUtil.d('onError：log拦截器出现错误');
    }

    return super.onError(err);
  }

}