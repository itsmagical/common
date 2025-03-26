import 'package:flutter/material.dart';
class DividerLine extends StatelessWidget {
  double height;
  double thickness;
  double indent;
  double endIndent;
  Color color;
  
  DividerLine({this.height = 0.1,this.color = const Color(0xff999999),this.thickness = 0.3,this.indent=0.0,this.endIndent = 0.0});
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: this.height,
      thickness: this.thickness,
      color: this.color,
      indent: this.indent,
      endIndent: this.endIndent,
    );
  }
}
