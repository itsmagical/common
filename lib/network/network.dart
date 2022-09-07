import 'dart:io';

import 'package:common/network/dio_options.dart';
import 'package:common/network/intercept/common_params_interceptor.dart';
import 'package:common/network/intercept/logging_interceptor.dart';
import 'package:common/network/network_manager.dart';
import 'package:common/util/util.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'base_network.dart';

///
/// dio http客户端包装类
/// dio的设置以及对post、get响应的处理。
/// [NetworkManager]管理baseUrl对应的Network对象
/// @author LiuHe
/// @created at 2020/12/16 ‏‎11:34

class Network extends BaseNetwork {

  Network({
    @required String baseUrl,
    DioOptions dioOptions,
  }) : super(baseUrl, dioOptions: dioOptions) {
    _init();
  }

  DefaultCookieJar _cookieJar;
  /// RESTful规范参数拦截器
  CommonParamsInterceptor commonParamsInterceptor;

  _init() {
    commonParamsInterceptor = CommonParamsInterceptor();
    setInterceptor(CommonParamsInterceptor());

//    /// 设置log拦截器
//    setInterceptor(LoggingInterceptor());

    _setProxy();
  }

  /// 启用cookie
  /// @param enableCookie true：启用cookie
  Network setEnableCookie(bool enableCookie) {
    if (enableCookie) {
      _cookieJar = CookieJar();
      dio.interceptors.add(CookieManager(_cookieJar));
    }
    return this;
  }

  /// 获取cookie
  /// 未启用cookie return null
  String get cookie {
    if (_cookieJar != null) {
      List<Cookie> cookies = _cookieJar.loadForRequest(Uri.parse(baseUrl));
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

  /// 获取通用参数拦截器
  CommonParamsInterceptor getCommonParamsInterceptor() {
    return commonParamsInterceptor;
  }

  /// 获取全部拦截器
  List<Interceptor> getInterceptors() {
    return dio.interceptors;
  }

  /// 设置抓包代理
  _setProxy() {
    var proxy = NetworkManager.instance.proxy;
    if (kDebugMode && Util.isNotEmptyText(proxy)) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        //这一段是解决安卓https抓包的问题
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return Platform.isAndroid;
        };
        client.findProxy = (uri) {
          return "PROXY $proxy";
        };
      };
    }
  }

}