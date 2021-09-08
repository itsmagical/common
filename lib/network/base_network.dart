import 'dart:convert';
import 'dart:io';

import 'package:common/network/dio_options.dart';
import 'package:common/network/network_manager.dart';
import 'package:common/util/log_util.dart';
import 'package:common/util/util.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'model/response.dart';


///
/// 初始化Dio、处理响应数据等
/// @author LiuHe
/// @created at 2020/12/23 17:03

abstract class BaseNetwork {

  BaseNetwork(this.baseUrl, {DioOptions dioOptions}) {
    _dioOptions = dioOptions;
    _init();
  }

  String baseUrl;
  DioOptions _dioOptions;

  BaseOptions options;

  Dio dio;

  _init() {

    DioOptions dioOptions = _dioOptions ??
        NetworkManager.instance.dioOptions ?? DioOptions();

    options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: dioOptions.connectTimeout,
      receiveTimeout: dioOptions.receiveTimeout,
      contentType: dioOptions.contentType,
      responseType: dioOptions.responseType,
    );

    dio = new Dio(options);

    _setProxy();
  }

  /// 设置代理
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

  MResponse getMResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic result = json.decode(response.data);
      bool success = result['success'];
      dynamic data = result['data'];
      String message = result['message'];
      int total = result['total'];
      LogUtil.d(json.encode(data));
      return MResponse(data: data, success: success, message: message, total: total);
    } else {
      return MResponse(data: null, success: false, message: response.statusMessage);
    }
  }

}