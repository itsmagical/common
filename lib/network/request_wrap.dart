import 'dart:convert';
import 'package:date_format/date_format.dart';

import 'model/pagination.dart';
import 'model/request.dart';


///
/// 将请求参数封装为标准的请求对象
/// @author LiuHe
/// @created at 2020/12/23 17:03

class RequestWrap {

  /// 获取请求json
  /// @params 请求参数
  /// @pagination 分页参数
  String getRequestJson<T>(T params, {Pagination pagination}) {

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
  String _getRequestTime() {
    return formatDate(
        DateTime.now(),
        ['yyyy', '-', 'mm', '-', 'dd', ' ', 'HH', ':', 'nn', ':', 'ss']
    );
  }

}