
///
/// 字典值模型
/// @author LiuHe
/// @created at 2021/9/10 16:39

class Dictionary {
  /// 字典值tableName
  String? tableName;
  /// 字典值attribute
  String? attribute;
  /// 此条字典值的value
  int? value;
  /// 字典值描述
  String? description;

  ///--------接版本接口字典值------------///
  /// 字典名称
  String? dictLabel;
  /// 字典纸
  int? dictValue;

  Dictionary({
    this.tableName,
    this.attribute,
    this.value,
    this.description,
    this.dictLabel,
    this.dictValue
  });

  Dictionary.fromJson(Map<String, dynamic> json) {
    tableName = json['tableName'];
    attribute = json['attribute'];
    value = json['value'];
    description = json['description'];
    dictLabel = json['dictLabel'];
    dictValue = json['dictValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tableName'] = this.tableName;
    data['attribute'] = this.attribute;
    data['value'] = this.value;
    data['description'] = this.description;
    data['dictLabel'] = this.dictLabel;
    data['dictValue'] = this.dictValue;
    return data;
  }
}
