import 'package:flutter/material.dart';

/// 加载中Widget
class LoadingStatusWidget extends StatefulWidget {

  LoadingStatusWidget({
    required this.context
  });

  final BuildContext context;

  @override
  State<StatefulWidget> createState() {
    return _LoadingStatusWidgetState(statusContext: context);
  }

}

class _LoadingStatusWidgetState extends State<LoadingStatusWidget> {

  _LoadingStatusWidgetState({
    required this.statusContext
  });

  BuildContext statusContext;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showLoadingDialog(statusContext);
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(Navigator.canPop(statusContext)) {
        Navigator.pop(statusContext, true);
      }
    });

    super.dispose();
  }

  showLoadingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
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
//        Navigator.pop(context);
        if(Navigator.canPop(context)) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      }

    });
  }

}