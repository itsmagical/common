
import 'package:common/network/dio_options.dart';
import 'package:common/util/util.dart';
import 'package:dio/dio.dart';

import 'base_network.dart';
import 'intercept/token_interceptor.dart';
import 'model/pagination.dart';
import 'model/response.dart';
import 'network_error.dart';

/// 网络请求 对应后台组件化的新接口
/// 使用token
/// @author LiuHe
/// @created at 2020/12/22 11:05

class NetWorkComponent extends BaseNetwork {

  NetWorkComponent(String baseUrl) : super(baseUrl);

//  static final NetWorkComponent _instance = NetWorkComponent._construction();
//
//  static NetWorkComponent get instance {
//    return _instance;
//  }
//
//  NetWorkComponent._construction() {
//    _init();
//  }

  TokenInterceptor tokenInterceptor;

  _init() {
    tokenInterceptor = TokenInterceptor();
    dio.interceptors.add(tokenInterceptor);
  }

  /// clear token header
  Future clearTokenHeader() async {
    if (Util.isNotNull(tokenInterceptor)) {
      await tokenInterceptor.clearTokenHeaderParam();
    }
  }

  /// get
  Future<MResponse> get(String path, {Map<String, dynamic> params, Map<String, dynamic> headers}) async {

    if (headers != null) {
      options.headers.addAll(headers);
    }

    try {
      Response response = await dio.get(path, queryParameters: params);
      return getMResponse(response);
    } on DioError catch(error) {
      String errorDesc = NetWorError.getErrorDesc(error);
      return MResponse(data: null, success: false, message: errorDesc);
    }
  }

  /// post
  /// @params Map
  /// @pagination 分页
  /// @headers 请求头
  Future<MResponse> post(String path, {Map<String, dynamic> params, Pagination pagination, Map<String, dynamic> headers}) async {

    if (headers != null) {
      options.headers.addAll(headers);
    }

    FormData formData = FormData.fromMap(params);

    try {
      Response response = await dio.post(path, data: formData);
      return getMResponse(response);
    } on DioError catch(error) {
      String errorDesc = NetWorError.getErrorDesc(error);
      return MResponse(data: null, success: false, message: errorDesc);
    }
  }

}