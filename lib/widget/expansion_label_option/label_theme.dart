import 'package:flutter/material.dart';

class LabelTheme {

  LabelTheme({
    this.rowCount = 1,
    this.spacing = 10,
    this.visibleColumn = 2,
    this.labelHeight = 40,
    this.isMultiple = false,
    Function? textColorBuilder,
    Function? decorationBuilder,
  }) {

    if (textColorBuilder == null) {
      this.textColorBuilder = _textColorBuilder;
    }

    if (decorationBuilder == null) {
      this.decorationBuilder = _decorationBuilder;
    }

  }

  /// 列数
  int rowCount;

  /// label 间距
  double spacing;

  /// 可见行数
  int visibleColumn;

  /// label 高度
  /// CustomMultiChildLayout 不能根据子项尺寸决定自身大小
  double labelHeight;

  bool isMultiple;

  /// label text color
  late Function textColorBuilder;

  /// label BoxDecoration
  late Function decorationBuilder;

  BoxDecoration _decorationBuilder(bool isOptioned) {
    return BoxDecoration(
      color: isOptioned ? Color(0xFF1B85FF) : Color(0xFFF7F7F7),
      borderRadius: BorderRadius.circular(4),
    );
  }

  Color _textColorBuilder(bool isOptioned) {
    return isOptioned ? Colors.white : Color(0xFF333333);
  }

}