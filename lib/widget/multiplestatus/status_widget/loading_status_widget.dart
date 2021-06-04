import 'package:flutter/material.dart';

/// 加载中Widget
class LoadingStatusWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoadingStatusWidgetState();
  }
}

class _LoadingStatusWidgetState extends State<LoadingStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        showLoadingDialog(context);
      }
    );
    super.initState();
  }

  @override
  void dispose() {
    /// 状态改变时dismiss
    Navigator.pop(context, true);
    super.dispose();
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
        context: context,
      barrierDismissible: true,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: const CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ),
        );
      }
    ).then((dispose) {
      /// dispose true状态改变时dismiss，
      /// null 手动dismiss 退出页面
      if (dispose == null) {
        Navigator.pop(context);
      }

    });
  }

}