
import 'refresh_token.dart';

/// 登录后返回的token
/// @author LiuHe
/// @created at 2020/12/22 13:13

class Authentication {

  /// token
  String access_token;

  /// 类型
  String token_type;

  /// 刷新token参数
  RefreshToken refresh_token;

  int expires_in;

  /// 过期时间
  String expiredTime;

  Authentication({
    this.access_token,
    this.token_type,
    this.refresh_token,
    this.expires_in,
    this.expiredTime,
  });

  Authentication.fromJson(Map<String, dynamic> json) {
    access_token = json['access_token'];
    token_type = json['token_type'];
    refresh_token = json['refresh_token'] != null
        ? new RefreshToken.fromJson(json['refresh_token'])
        : null;
    expires_in = json['expires_in'];
    expiredTime = json['expiredTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.access_token;
    data['token_type'] = this.token_type;
    if (this.refresh_token != null) {
      data['refresh_token'] = this.refresh_token.toJson();
    }
    data['expiredTime'] = this.expiredTime;
    return data;
  }

}