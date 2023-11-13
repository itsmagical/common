import 'package:dio/dio.dart';

class DioOptions {

  DioOptions({
    this.connectTimeout = const Duration(milliseconds: 10 * 1000),
    this.receiveTimeout = const Duration(milliseconds: 20 * 1000),
    this.contentType = Headers.jsonContentType,
    this.responseType = ResponseType.json,
    extra,
    headers
  }) {
    this.extra = extra ?? {};
    this.headers = headers ?? {};
  }

  /// 连接超时时间 毫秒
  Duration connectTimeout;

  /// 接收超时时间 毫秒
  Duration receiveTimeout;

  /// 请求头 content-type
  /// [BaseOptions.contentType]将contentType添加到headers中
  /// 如果header被清空，则默认使用[Headers.jsonContentType]
  String contentType;

  /// 响应类型
  ResponseType responseType;

  late Map<String, dynamic> extra;

  /// header
  late Map<String, dynamic> headers;



}