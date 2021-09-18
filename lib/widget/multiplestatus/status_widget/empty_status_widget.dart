
import 'package:flutter/material.dart';

import 'status_images.dart';

/// 暂无数据Widget
class EmptyStatusWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _EmptyStatusWidgetState();
  }

}

class _EmptyStatusWidgetState extends State<EmptyStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(StatusImages.status_no_data, width: 150, height: 118,),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
                '暂无数据',
              style: TextStyle(
                color: Color(0xff70879A),
                fontSize: 16
              ),
            )
          ),
        ],
      ),
    );
  }

}