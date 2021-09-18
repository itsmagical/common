import 'dart:convert';
import 'dart:io';

import 'package:common/network/dio_options.dart';
import 'package:common/network/network_error.dart';
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

  /// 全局Options配置
  BaseOptions options;

  /// http客户端对象
  /// 现仅对get、post做响应处理
  /// 其他请求方式请使用dio内置方法
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

  /// 原始响应对象转换为MResponse
  MResponse getMResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      ResponseType responseType = response.request.responseType;

      /// bytes: data type is List<int>
      /// stream: data type is ResponseBody
      if (responseType == ResponseType.bytes
          || responseType == ResponseType.stream) {
        return MResponse(data: response.data, success: true);
      }

      /// 响应数据
      dynamic result;
      var responseData = response.data;

      if (responseData.runtimeType == String) {
        result = json.decode(responseData);
      } else if (responseData is Map) {
        result = responseData;
      }
      if (result == null) {
        return MResponse(data: responseData, success: true);
      }

      bool success = result['success'];
      dynamic data = result['data'];
      String message = result['message'];
      int total = result['total'];
      return MResponse(data: data, success: success, message: message, total: total);
    } else {
      return MResponse(data: null, success: false, message: response.statusMessage);
    }
  }

}