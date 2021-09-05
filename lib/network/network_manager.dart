
import 'dart:collection';

import 'package:common/network/dio_options.dart';
import 'package:common/util/util.dart';

import 'network.dart';

///
/// @author LiuHe
/// @created at 2021/9/5 15:07

class NetworkManager {

  Network mainNetwork;
  Map<String, Network> networkMap = HashMap();

  NetworkManager._();

  static NetworkManager instance = NetworkManager._();

  DioOptions dioOptions;

  setDioOptions(DioOptions options) {
    dioOptions = options;
  }

  createMainNetwork(String baseUrl) {
    mainNetwork = Network(baseUrl: baseUrl);
    networkMap[baseUrl] = mainNetwork;
  }

  createNetwork(String baseUrl, {bool isMainNetwork}) {
    Network network = Network(baseUrl: baseUrl);
    if (isMainNetwork) {
      if (mainNetwork != null) {
        throw Exception('默认Network以创建，不能重复创建MainNetwork');
      }
      mainNetwork = network;
    }
    networkMap[baseUrl] = network;
  }

  Network getNetwork({String baseUrl}) {

    if (Util.isNotEmptyText(baseUrl)) {
      return networkMap[baseUrl];
    }

    return mainNetwork;
  }



}