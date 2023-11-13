import 'dart:convert';
import 'package:date_format/date_format.dart';

import 'model/pagination.dart';
import 'model/request.dart';


///
/// 将请求参数封装为标准的请求格式
/// 老版的请求参数格式，内部自定义格式，非RESTful规范
/// 该格式参数不直接传递，整体作为请求参数Key requestGson的值
/// data: 请求参数(必传)
/// pagination: 分页请求参数(非必传 需要分页时传递)
/// requestTime：请求时间(必传)
/// {"data":{"key":"value","key2":"value2"},"pagination":{"amount":20,"needsPaginate":true,"startPos":0},"requestTime":"2021-09-09 17:00:16"}
/// @author LiuHe
/// @created at 2020/12/23 17:03

class RequestWrap {

  /// 获取请求json
  /// @params 请求参数
  /// @pagination 分页参数
  static String getRequestJson<T>(T params, {Pagination? pagination}) {

    Request request = Request(
        data: params,
        requestTime: _getRequestTime(),
    );

    if (pagination != null) {
      request.pagination = pagination;
    }

    return json.encode(request);
  }

  /// 请求时间
  static String _getRequestTime() {
    return formatDate(
        DateTime.now(),
        ['yyyy', '-', 'mm', '-', 'dd', ' ', 'HH', ':', 'nn', ':', 'ss']
    );
  }

}