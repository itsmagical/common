
import 'dart:collection';

import 'package:common/network/dio_options.dart';
import 'package:common/util/util.dart';

import 'network.dart';

///
/// NetworkManager使用Map管理baseUrl对应的Network对象，
/// 应对应用中有多个服务，且使用的身份验证方式(Cookie,Token)和Content-Type不同的情况
/// @author LiuHe
/// @created at 2021/9/5 15:07

class NetworkManager {

  /// 默认Network, 即项目中最常用的
  Network _mainNetwork;
  /// Map存储baseUrl对应的Network
  Map<String, Network> _networkMap = HashMap();

  NetworkManager._();

  static NetworkManager instance = NetworkManager._();

  /// 默认Options
  DioOptions dioOptions;
  /// 网络代理地址
  String proxy;

  /// 设置默认Options
  setDioOptions(DioOptions options) {
    dioOptions = options;
  }

  /// 设置dio代理ip
  /// 调试使用
  setProxyIp(String proxyIp) {
    this.proxy = proxyIp;
  }

  /// 创建baseUrl对应的Network
  /// @param options 为Network单独设置Options,优先级大于默认Options
  /// @param isMainNetwork true: 默认Network
  createNetwork(String baseUrl, {DioOptions options, bool isMainNetwork}) {
    Network network = Network(baseUrl: baseUrl);
    if (isMainNetwork) {
      if (_mainNetwork != null) {
        throw Exception('默认Network以创建，不能重复创建');
      }
      _mainNetwork = network;
    }
    _networkMap[baseUrl] = network;
  }

  /// 获取baseUrl对应的Network
  /// @param baseUrl null: 默认Network
  Network getNetwork({String baseUrl}) {
    if (Util.isNotEmptyText(baseUrl)) {
      Network network = _networkMap[baseUrl];
      if (network == null) {
        throw Exception('请先使用createNetwork(baseUrl)创建baseUrl对应的Network ...');
      }
      return _networkMap[baseUrl];
    }

    if (_mainNetwork == null) {
      throw Exception('请先使用createNetwork(baseUrl, isMainNetwork = true)创建默认的Network ...');
    }
    return _mainNetwork;
  }



}