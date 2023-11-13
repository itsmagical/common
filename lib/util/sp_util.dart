import 'package:shared_preferences/shared_preferences.dart';


///
/// 统一的SharedPreferences实例
/// @author LiuHe
/// @created at 2021/1/19 13:41

class SpUtil {

  SpUtil._constructor();

  static final SpUtil instance = SpUtil._constructor();

  late SharedPreferences _prefs;

  /// 初始化
  Future<SharedPreferences> init() async {
    return _prefs = await SharedPreferences.getInstance();
  }

  /// 外部持久化数据使用
  SharedPreferences get prefs {

    if (_prefs == null) {
      throw Exception('未初始化SharedPreferences...');
    }

    return _prefs;
  }

  /// 清空存储的数据
  Future<bool> clear() async {
    return _prefs.clear();
  }

}