

import 'pagination.dart';

class Request<T> {
  T data;
  String requestTime;
  Pagination pagination;

  Request({
    this.data,
    this.pagination,
    this.requestTime,
  });

  Request.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    pagination = json['pagination'];
    requestTime = json['requestTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['pagination'] = this.pagination;
    data['requestTime'] = this.requestTime;
    return data;
  }
}
