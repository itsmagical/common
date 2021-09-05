import 'package:dio/dio.dart';

class DioOptions {

  DioOptions({
    this.connectTimeout = 10 * 1000,
    this.receiveTimeout = 10 * 1000,
    this.contentType,
    this.responseType = ResponseType.json,
    this.extra,
    this.headers
  });

  /// 连接超时时间 毫秒
  int connectTimeout;

  /// 接收超时时间 毫秒
  int receiveTimeout;

  /// 请求头 content-type
  String contentType;

  /// 响应类型
  ResponseType responseType;

  Map<String, dynamic> extra;

  Map<String, dynamic> headers;



}