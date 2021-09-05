import 'dart:convert';

import 'package:common/network/dio_options.dart';
import 'package:common/network/network_manager.dart';
import 'package:common/util/log_util.dart';
import 'package:dio/dio.dart';

import 'model/response.dart';


///
/// 初始化Dio、处理响应数据等
/// @author LiuHe
/// @created at 2020/12/23 17:03

abstract class BaseNetwork {

  BaseNetwork(this.baseUrl) {
    _init();
  }

  BaseOptions options;

  Dio dio;

  String baseUrl;

  _init() {

    DioOptions dioOptions = NetworkManager.instance.dioOptions ?? DioOptions();

    options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: dioOptions.connectTimeout,
      receiveTimeout: dioOptions.receiveTimeout,
      contentType: dio.options.contentType,
      responseType: dio.options.responseType,
    );

    dio = new Dio(options);
  }

  /// 设置base url
  setBaseUrl(String url) {
    dio.options.baseUrl = url;
  }

  MResponse getMResponse(Response response) {
    // LogUtil.d("response: ${jsonEncode(response.data)}");
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