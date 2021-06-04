import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


/// System UI style
/// @author LiuHe
/// @created at 2020/12/17 10:30

class SystemUiUtil {

  /// 状态栏透明， 黑色图标
  static void cleanDarkBrightness() {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor:Colors.transparent,
        statusBarIconBrightness: Brightness.dark
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

}