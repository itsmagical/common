
///
/// 字典值模型
/// @author LiuHe
/// @created at 2021/9/10 16:39

class Dictionary {
  /// 字典值tableName
  String tableName;
  /// 字典值attribute
  String attribute;
  /// 此条字典值的value
  int value;
  /// 字典值描述
  String description;

  Dictionary({this.tableName, this.attribute, this.value, this.description});

  Dictionary.fromJson(Map<String, dynamic> json) {
    tableName = json['tableName'];
    attribute = json['attribute'];
    value = json['value'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tableName'] = this.tableName;
    data['attribute'] = this.attribute;
    data['value'] = this.value;
    data['description'] = this.description;
    return data;
  }
}
