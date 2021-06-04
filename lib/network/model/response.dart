
/// 响应对象
class MResponse<T> {

  /// 响应数据
  T data;

  /// 请求状态
  bool success;

  /// 处理信息
  String message;

  int total;

  MResponse({
    this.data,
    this.success,
    this.message,
    this.total,
  });

  MResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    success = json['success'];
    message = json['message'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['success'] = this.success;
    data['message'] = this.message;
    data['total'] = this.total;
    return data;
  }

}