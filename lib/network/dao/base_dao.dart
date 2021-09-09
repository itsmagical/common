
import 'package:common/network/model/pagination.dart';
import 'package:common/network/request_wrap.dart';


///
/// 数据层基类
/// @author LiuHe
/// @created at 2021/1/26 ‏‎15:43

class BaseDao {

  /// 获取老版请求参数Map
  Map<String, dynamic> getRequestJsonMap<T>(T params, {Pagination pagination}) {
    return {
      'requestGson': RequestWrap.getRequestJson(params, pagination: pagination)
    };
  }

}