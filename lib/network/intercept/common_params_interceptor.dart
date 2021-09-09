
import 'package:dio/dio.dart';


///
/// 适用于RESTful规范的header、body通用参数拦截器
/// @author LiuHe
/// @created at 2021/9/9 10:29

class CommonParamsInterceptor extends Interceptor {

  /// header参数Map
  Map<String, dynamic> _headerParamsMap = {};

  /// body or get参数Map
  Map<String, dynamic> _commonParamsMap = {};

  /// 设置header参数
  setHeaderParam(String key, dynamic value) {
    _headerParamsMap[key] = value;
  }

  /// 移除header参数
  removeHeaderParam(String key) {
    _headerParamsMap.remove(key);
  }

  /// 设置通用参数
  setCommonParam(String key, dynamic value) {
    _commonParamsMap[key] = value;
  }

  /// 移除通用参数
  removeCommonParam(String key) {
    _commonParamsMap.remove(key);
  }

  @override
  Future onRequest(RequestOptions options) {

    var headers = options.headers;

    if (_headerParamsMap.isNotEmpty) {
      headers.addAll(_headerParamsMap);
    }

    if (_commonParamsMap.isNotEmpty) {

      if (options.method == 'GET') {
        options.queryParameters.addAll(_commonParamsMap);
      }

      if (options.method == 'POST') {
        var data = options.data;
        if (data is Map) {
          data.addAll(_commonParamsMap);
        }
      }
    }

    return super.onRequest(options);
  }

}