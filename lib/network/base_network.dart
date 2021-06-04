import 'dart:convert';

import 'package:common/util/log_util.dart';
import 'package:dio/dio.dart';

import 'model/response.dart';


///
/// 初始化Dio、处理响应数据等
/// @author LiuHe
/// @created at 2020/12/23 17:03

abstract class BaseNetwork {

  BaseNetwork() {
    _init();
  }

  BaseOptions options;

  Dio dio;

  _init() {
    options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.plain,
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