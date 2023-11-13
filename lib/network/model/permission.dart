
///
/// 权限Model
/// @author LiuHe
/// @created at 2020/12/23 10:50

class Permission {
  int? dataId;
  int? parentId;
  String? name;
  String? menuText;
  int? menuLevel;

  Permission(
      {this.dataId, this.parentId, this.name, this.menuText, this.menuLevel});

  Permission.fromJson(Map<String, dynamic> json) {
    dataId = json['dataId'];
    parentId = json['parentId'];
    name = json['name'];
    menuText = json['menuText'];
    menuLevel = json['menuLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataId'] = this.dataId;
    data['parentId'] = this.parentId;
    data['name'] = this.name;
    data['menuText'] = this.menuText;
    data['menuLevel'] = this.menuLevel;
    return data;
  }
}
