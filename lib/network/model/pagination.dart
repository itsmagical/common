

/// 分页
class Pagination {

  /// 标记是否分页
  bool needsPaginate;

  /// 分页的起始记录序号
  int startPos;

  /// 每页需要取出的记录大小。
  int amount;

  Pagination({this.needsPaginate, this.startPos, this.amount}) {
    needsPaginate = true;
    amount = amount ?? 20;
  }

  Pagination.fromJson(Map<String, dynamic> json) {
    needsPaginate = json['needsPaginate'];
    startPos = json['startPos'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['needsPaginate'] = this.needsPaginate;
    data['startPos'] = this.startPos;
    data['amount'] = this.amount;
    return data;
  }
}
