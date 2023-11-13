import 'dart:convert';

import 'package:common/util/log_util.dart';
import 'package:dio/dio.dart';


///
/// 网络请求Log拦截器
/// @author LiuHe
/// @created at 2021/9/9 10:02

class LoggingInterceptor extends Interceptor {

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    try {
      RequestOptions request = response.requestOptions;

      Map<String, dynamic> headerMap = request.headers;

      String headers = '';

      headerMap.forEach((key, value) {
        headers += '$key: $value \n ';
      });

      LogUtil.d(
          '''
      -------------------headers----------------------------
      headers:
        $headers
      -------------------body----------------------------
      url:
        ${request.baseUrl + request.path}
      parameters:
        ${getRequestDataParams(request)}
      response:
        ${jsonEncode(response.data)}
      '''
      );
    } catch(error) {
      LogUtil.d('onResponse：log拦截器出现错误');
    }
    handler.next(response);
  }

  /// 获取请求参数
  /// @param requestData request.data
  String getRequestDataParams(RequestOptions request) {

    if (request.method == 'GET') {
      return jsonEncode(request.queryParameters);
    }

    dynamic requestData = request.data;
    String requestParams = '';
    if (requestData is FormData) {
      List<dynamic> fields = requestData.fields;
      if (fields != null && fields.length > 0) {
        Map<String, dynamic> transferMap = {};
        fields.forEach((field) {
          if (field is MapEntry) {
            transferMap[field.key] = field.value;
          }
        });
        requestParams = jsonEncode(transferMap);
      }
    } else {
      requestParams = jsonEncode(requestData);
    }
    return requestParams;
  }

  @override
  void onError(DioException exception, ErrorInterceptorHandler handler) {
    try {
      var request = exception.requestOptions;

      LogUtil.d(
          '''
      url：
        ${request.baseUrl + request.path}
      parameters：
        ${getRequestDataParams(request)}
      errorMessage：
        ${exception.message}
      
      '''
      );
    } catch(error) {
      LogUtil.d('onError：log拦截器出现错误');
    }

    handler.next(exception);
  }

}