
import 'package:common/network/model/pagination.dart';
import 'package:common/network/request_wrap.dart';
import 'package:flutter/material.dart';


///
/// 数据层基类
/// @author LiuHe
/// @created at 2021/1/26 ‏‎15:43

class BaseDao {

  /// 获取老版请求参数Map
  /// @param params 被包装的请求参数
  /// @param pagination 分页参数(按条数查询)
  Map<String, dynamic> getRequestJsonMap<T>(T params, {Pagination? pagination}) {
    return {
      'requestGson': RequestWrap.getRequestJson(params, pagination: pagination)
    };
  }

  /// 分页请求参数(按页数查询，新的接口使用)
  /// @param page 页数
  /// @param limit 每页多少条
  /// @param needsSort 是否排序
  Map<String, dynamic> getPageMap({
    int? page,
    int? limit,
    bool? needsSort
  }) {
    return {
      'page': page ?? 1,
      'limit': limit ?? 20,
      'needsSort': needsSort ?? true
    };
  }
  
}