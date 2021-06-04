

import 'permission.dart';

class UserModel {
  /// 用户id
  int userId;
  /// 用户名
  String userName;

  /// 登录名
  String loginName;
  /// 密码
  String password;

  /// 手机号
  String mobile;
  /// 头像地址
  String photoPath;
  /// 性别
  String gender;
  /// 邮箱
  String postBox;

  /// 角色
  String userRole;
  /// 岗位
  String positions;

  /// 用户组织id
  int userOrgId;
  /// 部门id
  int userOrgParId;
  /// 顶级组织id
  int userOrgPerId;
  /// 顶级组织描述
  String userOrgParStr;

  /// 监管类型
  /// 焚烧 1
  /// 飞灰 2
  int superviseType;

  /// 权限
  List<Permission> permInstanceDtos;

  UserModel({
    this.userId,
    this.userName,
    this.loginName,
    this.password,
    this.mobile,
    this.photoPath,
    this.gender,
    this.postBox,
    this.userRole,
    this.positions,
    this.userOrgId,
    this.userOrgParId,
    this.userOrgPerId,
    this.userOrgParStr,
    this.superviseType,
    this.permInstanceDtos,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    loginName = json['loginName'];
    password = json['password'];
    mobile = json['mobile'];
    photoPath = json['photoPath'];
    gender = json['gender'];
    postBox = json['postBox'];
    userRole = json['userRole'];
    positions = json['positions'];
    userOrgId = json['userOrgId'];
    userOrgParId = json['userOrgParId'];
    userOrgPerId = json['userOrgPerId'];
    userOrgParStr = json['userOrgParStr'];
    superviseType = json['superviseType'];
    if (json['permInstanceDtos'] != null) {
      permInstanceDtos = new List<Permission>();
      json['permInstanceDtos'].forEach((v) {
        permInstanceDtos.add(new Permission.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['loginName'] = this.loginName;
    data['password'] = this.password;
    data['mobile'] = this.mobile;
    data['photoPath'] = this.photoPath;
    data['gender'] = this.gender;
    data['postBox'] = this.postBox;
    data['userRole'] = this.userRole;
    data['positions'] = this.positions;
    data['userOrgId'] = this.userOrgId;
    data['userOrgParId'] = this.userOrgParId;
    data['userOrgPerId'] = this.userOrgPerId;
    data['userOrgParStr'] = this.userOrgParStr;
    data['superviseType'] = this.superviseType;
    if (this.permInstanceDtos != null) {
      data['permInstanceDtos'] =
          this.permInstanceDtos.map((v) => v.toJson()).toList();
    }
    return data;
  }

}