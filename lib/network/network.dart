import 'dart:io';

import 'package:common/util/util.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/widgets.dart';

import 'base_network.dart';
import 'model/response.dart';
import 'network_error.dart';
import 'request_wrap.dart';


///
/// 网络请求
/// Post field is requestGson
/// @author LiuHe
/// @created at 2020/12/16 ‏‎11:34

class Network extends BaseNetwork {

  Network({
    @required String baseUrl
  }) : super(baseUrl) {
    _init();
  }

  RequestWrap requestWrap;

  DefaultCookieJar cookieJar;

  _init() {
    requestWrap = RequestWrap();

    cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
  }

  /// 获取cookie
  String get cookie {
    List<Cookie> cookies = cookieJar.loadForRequest(Uri.parse(dio.options.baseUrl));
    if (Util.isNotEmpty(cookies)) {
      Cookie cookie = cookies[0];
      String cookieJson = cookie.toString();
      return cookieJson;
    }
    return null;
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
      Response response = await dio.get(
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
      Response response = await dio.post(
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

  /// 设置拦截器
  Network setInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
    return this;
  }




}