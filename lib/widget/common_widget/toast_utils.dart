//一个loading的工具类
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';


class LoadingUtil {
  static CancelFunc? _loading; // 用于存储当前的 loading 句柄
  static bool _isShowing = false; // 记录是否正在显示

  /// 显示加载动画
  static void showLoading({
    Color indicatorColor = Colors.white, // 加载指示器颜色
    Color backgroundColor = Colors.black54, // 背景颜色
    double size = 50.0, // 加载框大小
    double borderRadius = 10.0, // 圆角
  }) {
    if (_isShowing) return; // 防止重复显示
    _isShowing = true;

    _loading = BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
            ),
          ),
        );
      },
    );
  }

  /// 隐藏加载动画
  static void hideLoading() {
    if (_loading != null) {
      _loading!();
      _loading = null;
      _isShowing = false;
    }
  }


  static void showText({required String message
  }) {
    BotToast.showText(
      text: message,
    );
  }
  /// 是否正在显示加载动画
  static bool get isLoading => _isShowing;
}





