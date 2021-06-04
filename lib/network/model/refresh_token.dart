

///
/// refreshToken
/// token过期后需要refreshToken获取新的token
/// @author LiuHe
/// @created at 2020/12/22 13:13

class RefreshToken {

  /// refreshToken
  String value;

  /// refreshToken过期时间，refreshToken过期后需重新登录
  /// refreshToken手机端暂时定为不过期，暂时不需要处理过期重新登录
  String expiration;

  RefreshToken({
    this.value,
    this.expiration,
  });

  RefreshToken.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['expiration'] = this.expiration;
    return data;
  }

}