import 'package:flutter/material.dart';

class LabelTheme {

  LabelTheme({
    this.rowCount = 1,
    this.spacing = 10,
    this.visibleColumn = 2,
    this.labelHeight = 40,
    this.isMultiple = false,
    this.textColorBuilder,
    this.decorationBuilder,
  }) {

    if (textColorBuilder == null) {
      textColorBuilder = _textColorBuilder;
    }

    if (decorationBuilder == null) {
      decorationBuilder = _decorationBuilder;
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
  Function textColorBuilder;

  /// label BoxDecoration
  Function decorationBuilder;

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