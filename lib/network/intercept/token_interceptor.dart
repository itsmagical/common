

import 'package:common/network/model/authentication.dart';
import 'package:common/network/model/refresh_token.dart';
import 'package:common/network/model/response.dart';
import 'package:common/network/model/token.dart';
import 'package:common/network/network.dart';
import 'package:common/util/user_util.dart';
import 'package:common/util/util.dart';
import 'package:dio/dio.dart';


/// Token拦截器
/// token过期后自动刷新
/// 刷新token(refresh_token)过期后需重新登录
class TokenInterceptor extends Interceptor {

  TokenInterceptor({String baseUrl, this.reLoginCallback}) {

    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
  }

  /// 请求头参数包含有该名称的key，则跳过token拦截
  static final ignoreTokenInterceptor = 'ignore_token_interceptor';

  /// 请求头参数包含有该名称的key，则不执行登录回调
  static final disableReLoginCallback = 'disable_relogin_callback';

  Map<String, dynamic> _tokenParamMap = {};

  /// 请求token的地址
  String baseUrl;

  /// 刷新token过期，重新登录回调
  VoidCallback reLoginCallback;

  Dio _dio;

  @override
  Future onRequest(RequestOptions options) async {
    var headers = options.headers;

    bool reloginEnable = true;

    if (headers != null) {
      if (headers.containsKey(ignoreTokenInterceptor)) {
        headers.remove(ignoreTokenInterceptor);
        return options;
      }

      if (headers.containsKey(disableReLoginCallback)) {
        headers.remove(disableReLoginCallback);
        reloginEnable = false;
      }

    }

    if (isTokenExpiredTime(reloginEnable)) {
      /// 刷新token 不能携带已过期的token
      headers.remove('Authorization');
      await saveNewToken(reloginEnable);
    }

    headers.addAll(_tokenParamMap);

    return options;

    // return super.onRequest(options);
  }


  /// @return true token is expired
  bool isTokenExpiredTime(bool reloginEnable) {

    Authentication token = UserUtil.instance.getToken();

    if (token != null) {

      RefreshToken refreshToken = token.refresh_token;

      /// 刷新token为null
      if (!Util.isNotNull(refreshToken) || !Util.isNotEmptyText(refreshToken.value)) {
        reLogin(reloginEnable);
        return false;
      }

      /// 刷新token的过期时间
      String expiration = refreshToken.expiration;

      if (Util.isNotEmptyText(expiration)) {
        DateTime expiredTime = DateTime.parse(expiration);
        bool isExpired = expiredTime.isBefore(DateTime.now());
        /// 刷新过期，重新登录
        if (isExpired) {
          reLogin(reloginEnable);
          return false;
        }
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
  Future saveNewToken(bool reloginEnable) async {
    String path = 'oauth/token';

    Map<String, String> headers = {};
    headers['Authorization'] = 'Basic c2luaWVjbzpzaW5pZWNv';

    Authentication authentication = UserUtil.instance.getToken();

    Map<String, String> params = {};
    params['grant_type'] = 'refresh_token';
    params['refresh_token'] = authentication.refresh_token.value;

    _dio.options.headers = headers;
    try {
      Response response = await _dio.post(path, data: params, options: Options(contentType: Headers.formUrlEncodedContentType));

      if (response.statusCode == 200) {
        var tokenMap = response.data;
        print('token刷新成功：${tokenMap.toString()}');
        Token token = Token.fromJson(tokenMap);
        authentication.access_token = token.access_token;
        authentication.expiredTime = token.expiredTime;
        authentication.refresh_token.value = token.refresh_token;
        UserUtil.instance.saveToken(authentication);
        addTokenHeaderParam(token.access_token);
      } else {
        print('刷新token错误');
        reLogin(reloginEnable);
      }

      return response;

    } catch(error) {
      reLogin(reloginEnable);
    }

    return null;
  }

  /// 添加token
  /// @param token
  void addTokenHeaderParam(String param) {
    _tokenParamMap['Authorization'] = "Bearer " + param;
  }

  /// 清除token
  Future clearTokenHeaderParam() async {
    await UserUtil.instance.clearToken();
    _tokenParamMap.clear();
  }

  /// 登录回调
  reLogin(bool reloginEnable) {
    if (reLoginCallback != null) {
      if (reloginEnable) {
        reLoginCallback();
      }
    }
  }

}