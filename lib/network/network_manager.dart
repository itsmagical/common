
import 'dart:collection';

import 'package:common/network/dio_options.dart';
import 'package:common/util/util.dart';

import 'network.dart';

///
/// NetworkManager使用Map管理baseUrl对应的Network对象，
/// 适用应用内包含多个后台服务的场景，
/// 以及使用的身份验证方式(Cookie,Token)和Content-Type不同的情况
///
/// example:
///
///    NetworkManager networkManager = NetworkManager.instance;
///    /// 创建默认Network对象
///    networkManager.createNetwork('baseUrl', isMainNetwork: true);
///
///    /// 获取默认Network对象, 且使用token验证身份
///    Network network = networkManager.getNetwork()
///        .setInterceptor(TokenInterceptor());
///    /// post 请求
///    network.post('path');
///
///    /// 创建其他服务的Network对象, 且content-type是 application/json
///    networkManager.createNetwork('other server baseUrl',
///        baseUrlTag: 'base_url_tag',
///        options: DioOptions(contentType: Headers.jsonContentType)
///    );
///    /// 获取其他服务的Network对象，且使用cookie验证身份
///    Network otherNetwork = networkManager
///        .getNetwork(baseUrlTag: 'base_url_tag') // or .getNetwork(baseUrl: 'other server baseUrl')
///        .setEnableCookie(true);
///    /// post options优先级 > 创建Network配置的options
///    otherNetwork.post('path', options: DioOptions(contentType: Headers.formUrlEncodedContentType));
///
/// @author LiuHe
/// @created at 2021/9/5 15:07

class NetworkManager {

  /// 默认使用的Network
  Network? _mainNetwork;
  /// Map存储baseUrl对应的Network
  Map<String, Network> _networkMap = HashMap();
  /// baseUrl标记，存储Tag标记对应的baseUrl
  Map<String, String> _baseUrlTagMap = HashMap();

  NetworkManager._();

  static NetworkManager instance = NetworkManager._();

  /// 默认Options
  DioOptions? dioOptions;
  /// 网络代理地址
  String? proxy;

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
  /// @param baseUrlTag baseUrl tag标记，tag与url关联,可使用tag获取Network
  /// @param isMainNetwork true: 默认Network
  void createNetwork(String baseUrl, {
    String? baseUrlTag, DioOptions? options, bool isMainNetwork = false
  }) {
    Network? network = _networkMap[baseUrl];
    if (network != null) {
      throw Exception('Network已创建，不能重复创建');
    }

    network = Network(baseUrl: baseUrl, dioOptions: options);
    if (isMainNetwork) {
      if (_mainNetwork != null) {
        throw Exception('默认Network以创建，不能重复创建');
      }
      _mainNetwork = network;
    }
    _networkMap[baseUrl] = network;
    /// 存储url标记
    if (Util.isNotEmptyText(baseUrlTag)) {
      _baseUrlTagMap[baseUrlTag!] = baseUrl;
    }
  }

  /// 获取baseUrl对应的Network
  /// @param baseUrl 根据url获取Network, null: 默认Network;
  /// @param baseUrlTag 根据tag获取Network, 优先级小于baseUrl获取
  Network getNetwork({String? baseUrl, String? baseUrlTag}) {
    /// baseUrl为空，tag获取才会生效
    if (!Util.isNotEmptyText(baseUrl) && Util.isNotEmptyText(baseUrlTag)) {
      baseUrl = _baseUrlTagMap[baseUrlTag];
      if (baseUrl == null) {
        throw Exception('baseUrlTag对应的baseUrl不存在，请确认正确的Tag标记');
      }
    }
    if (Util.isNotEmptyText(baseUrl)) {
      Network? network = _networkMap[baseUrl];
      if (network == null) {
        throw Exception('请先使用createNetwork(baseUrl)创建baseUrl对应的Network ...');
      }
      return _networkMap[baseUrl]!;
    }

    if (_mainNetwork == null) {
      throw Exception('请先使用createNetwork(baseUrl, isMainNetwork = true)创建默认的Network ...');
    }
    return _mainNetwork!;
  }

  /// 判断urlTag是否已创建
  bool isTagCreated({String? tag}) {
    if (Util.isNotEmptyText(tag)) {
      return _baseUrlTagMap.containsKey(tag);
    }
    return false;
  }

}