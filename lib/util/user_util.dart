import 'dart:convert';

import 'package:common/network/model/authentication.dart';
import 'package:common/network/model/user_model.dart';
import 'package:common/util/sp_util.dart';
import 'package:common/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';


///
/// User info util
/// @author LiuHe
/// @created at 2021/1/26 15:47

class UserUtil {

  static final UserUtil instance = UserUtil._constructor();

  UserUtil._constructor() {
    _prefs = SpUtil.instance.prefs;
  }

  SharedPreferences _prefs;

  /// Key 用户信息
  static const String _KEY_USER_INFO = 'user_info';

  /// key Token
  static const String _KEY_TOKEN = 'token';

  Future<bool> saveUserModel(UserModel userInfo) async {
    return _prefs.setString(_KEY_USER_INFO, json.encode(userInfo));
  }

  UserModel getUserModel() {
    String userInfoStr = _prefs.getString(_KEY_USER_INFO);
    if (Util.isNotEmptyText(userInfoStr)) {
      dynamic userInfoMap = json.decode(userInfoStr);
      return UserModel.fromJson(userInfoMap);
    }
    return null;
  }

  /// 登录人id
  int getUserId() {
    String userInfoStr = _prefs.getString(_KEY_USER_INFO);
    if (Util.isNotEmptyText(userInfoStr)) {
      dynamic userInfoMap = json.decode(userInfoStr);
      return UserModel.fromJson(userInfoMap).userId;
    }
    return null;
  }

  /// 清除用户信息
  Future<bool> clearUserModel() {
    return _prefs.remove(_KEY_USER_INFO);
  }

  /// 保存token
  Future<bool> saveToken(Authentication authentication) async {
    return _prefs.setString(_KEY_TOKEN, json.encode(authentication));
  }

  /// 获取token
  Authentication getToken() {
    String tokenJson = _prefs.getString(_KEY_TOKEN);
    if (Util.isNotEmptyText(tokenJson)) {
      var tokenMap = json.decode(tokenJson);
      return Authentication.fromJson(tokenMap);
    }
    return null;
  }

  /// 清除保存的token
  Future<bool> clearToken() {
    return _prefs.remove(_KEY_TOKEN);
  }

}