
import 'package:flutter/material.dart';

import '../status_handler.dart';
import 'status_images.dart';

/// 错误Widget
class ErrorStatusWidget extends StatefulWidget {

  ErrorStatusWidget(this.handler);

  final StatusHandler handler;

  @override
  State<StatefulWidget> createState() {
    return _ErrorStatusWidgetState();
  }

}

class _ErrorStatusWidgetState extends State<ErrorStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.handler.onRetryingCommand();
      },
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(StatusImages.status_error),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  '出现错误，点击重试',
                  style: TextStyle(
                      color: Color(0xff70879A),
                      fontSize: 16
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

}