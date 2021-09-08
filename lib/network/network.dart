import 'dart:io';

import 'package:common/network/dio_options.dart';
import 'package:common/util/util.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/widgets.dart';

import 'base_network.dart';
import 'model/response.dart';
import 'network_error.dart';


///
/// 网络请求
/// @author LiuHe
/// @created at 2020/12/16 ‏‎11:34

class Network extends BaseNetwork {

  Network({
    @required String baseUrl,
    DioOptions dioOptions,
  }) : super(baseUrl, dioOptions: dioOptions) {
    _init();
  }

  DefaultCookieJar cookieJar;

  _init() {

  }

  /// get
  Future<MResponse<T>> get<T>(
    String path, {
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      ProgressCallback onReceiveProgress,
  }) async {
    try {
      Response<T> response = await dio.get<T>(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress
      );
      return getMResponse(response);
    } on DioError catch(error) {
      String errorDesc = NetWorError.getErrorDesc(error);
      return MResponse(data: null, success: false, message: errorDesc);
    }
  }

  /// post
  Future<MResponse<T>> post<T>(
    String path, {
      data,
      Map<String, dynamic> queryParameters,
      Options options,
      CancelToken cancelToken,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
  }) async {
    try {
      Response<T> response = await dio.post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress
      );
      return getMResponse(response);
    } on DioError catch(error) {
      String errorDesc = NetWorError.getErrorDesc(error);
      return MResponse(data: null, success: false, message: errorDesc);
    }
  }

  ///
  Network setEnableCookie(bool enableCookie) {
    if (enableCookie) {
      cookieJar = CookieJar();
      dio.interceptors.add(CookieManager(cookieJar));
    }
    return this;
  }

  /// 获取cookie
  String get cookie {
    if (cookieJar != null) {
      List<Cookie> cookies = cookieJar.loadForRequest(Uri.parse(dio.options.baseUrl));
      if (Util.isNotEmpty(cookies)) {
        Cookie cookie = cookies[0];
        String cookieJson = cookie.toString();
        return cookieJson;
      }
    }
    return null;
  }

  /// 设置拦截器
  Network setInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
    return this;
  }

}