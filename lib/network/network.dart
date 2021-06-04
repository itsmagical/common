import 'dart:io';

import 'package:common/util/util.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'base_network.dart';
import 'model/pagination.dart';
import 'model/response.dart';
import 'network_error.dart';
import 'request_wrap.dart';


///
/// 网络请求
/// Post field is requestGson
/// @author LiuHe
/// @created at 2020/12/16 ‏‎11:34

class Network extends BaseNetwork {

  static final Network _instance = Network._constructor();

  static Network get instance {
    return _instance;
  }

  Network._constructor() {
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
  /// @params Map or dto
  /// @pagination 分页
  /// @headers 请求头
  Future<MResponse> post(String path, {dynamic params, Pagination pagination, Map<String, dynamic> headers}) async {

    if (headers != null) {
      options.headers.addAll(headers);
    }

    // Request dto 序列化后的json字符串
    String requestParams = requestWrap.getRequestJson(params, pagination: pagination);

    Map<String, dynamic> queryMap = {};
    queryMap['requestGson'] = requestParams;
    FormData formData = FormData.fromMap(queryMap);

    try {
      Response response = await dio.post(path, data: formData);
      return getMResponse(response);
    } on DioError catch(error) {
        String errorDesc = NetWorError.getErrorDesc(error);
        return MResponse(data: null, success: false, message: errorDesc);
    }
  }

}