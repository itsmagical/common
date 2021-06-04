

import 'package:common/network/model/authentication.dart';
import 'package:common/network/model/token.dart';
import 'package:common/util/user_util.dart';
import 'package:common/util/util.dart';
import 'package:dio/dio.dart';

import '../network_component.dart';

/// Token拦截器

class TokenInterceptor extends Interceptor {

  Map<String, dynamic> _tokenParamMap = {};

  @override
  Future onRequest(RequestOptions options) async {

    if (isTokenExpiredTime()) {
      NetWorkComponent.instance.dio.interceptors.requestLock.lock();
      /// 刷新token 不能携带已过期的token
      options.headers.remove('Authorization');
      await saveNewToken()
      .then((value) {

      });
      NetWorkComponent.instance.dio.interceptors.requestLock.unlock();
    }

    options.headers.addAll(_tokenParamMap);

    return options;

    // return super.onRequest(options);
  }


  /// @return true token is expired
  bool isTokenExpiredTime() {

    Authentication token = UserUtil.instance.getToken();

    if (token != null) {

      /// 刷新token为null
      if (!Util.isNotNull(token.refresh_token) || !Util.isNotEmptyText(token.refresh_token.value)) {
        return false;
      }

      String expiredTimeString = token.expiredTime;

      if (Util.isNotEmptyText(expiredTimeString)) {
        DateTime expiredTime = DateTime.parse(expiredTimeString);
        bool isExpired =  expiredTime.isBefore(DateTime.now());

        /// 登录后存储的token有效，初始化token header
        if (!isExpired && _tokenParamMap.length == 0) {
          addTokenHeaderParam(token.access_token);
        }

        return isExpired;
      }

    }

    return false;
  }

  /// token过期 根据refreshToken 刷新token
  Future saveNewToken() async {
    String path = 'oauth/token';

    Map<String, String> headers = {};
    headers['Authorization'] = 'Basic c2luaWVjbzpzaW5pZWNv';

    Authentication authentication = UserUtil.instance.getToken();

    Map<String, String> params = {};
    params['grant_type'] = 'refresh_token';
    params['refresh_token'] = authentication.refresh_token.value;

    return await NetWorkComponent.instance.post(path, headers: headers, params: params)
    .then((response) {
      if (response.success) {
        var tokenMap = response.data;
        Token token = Token.fromJson(tokenMap);
        authentication.access_token = token.access_token;
        authentication.expiredTime = token.expiredTime;
        authentication.refresh_token.value = token.refresh_token;
        UserUtil.instance.saveToken(authentication);
        addTokenHeaderParam(token.access_token);
      }
    });
  }

  /// 添加token
  /// @param token
  void addTokenHeaderParam(String param) {
    _tokenParamMap['Authorization'] = "Bearer " + param;
  }

  /// 清除token
  Future clearTokenHeaderParam() async {
    await UserUtil.instance.clearToken();
    NetWorkComponent.instance.options.headers.remove('Authorization');
    _tokenParamMap.clear();
  }

}