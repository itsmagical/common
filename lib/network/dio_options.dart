import 'package:dio/dio.dart';

class DioOptions {

  DioOptions({
    this.connectTimeout = 10 * 1000,
    this.receiveTimeout = 10 * 1000,
    this.contentType = Headers.jsonContentType,
    this.responseType = ResponseType.json,
    extra,
    headers
  }) {
    this.extra = extra ?? {};
    this.headers = headers ?? {};
  }

  /// 连接超时时间 毫秒
  int connectTimeout;

  /// 接收超时时间 毫秒
  int receiveTimeout;

  /// 请求头 content-type
  /// [BaseOptions.contentType]将contentType添加到headers中
  /// 如果header被清空，则默认使用[Headers.jsonContentType]
  String contentType;

  /// 响应类型
  ResponseType responseType;

  Map<String, dynamic> extra;

  /// header
  Map<String, dynamic> headers;



}