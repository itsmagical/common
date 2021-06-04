import 'package:flutter/material.dart';

class NavigatorUtil {

  static Future push(BuildContext context, Widget page) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  /// push给定的新路由，清空之前的所有路由
  static Future pushAndRemoveUntil(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => page),
        (route) => false
    );
  }
  
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

}