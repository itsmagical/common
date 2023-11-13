import 'package:flutter/material.dart';
import 'label_theme.dart';

/// 自定义排列Label布局
/// CustomMultiChildLayout不能根据子项决定其自身大小
/// 需要设置Label固定高度确定自身高度
/// @author LiuHe
/// @created at 2020/11/23 15:42

class ExpansionLabelLayout extends CustomMultiChildLayout {

  ExpansionLabelLayout(
      {Key? key,
        required this.children,
        required this.optionedColumn,
        required this.theme,
        required this.animationValue,
      }) :
        super(
          key: key,
          delegate: ExpansionLabelLayoutDelegate(
              children: children,
              optionedColumn: optionedColumn,
              animationValue: animationValue,
              theme: theme
          ),
          children: children
      );

  final List<Widget> children;

  final int optionedColumn;

  final double animationValue;

  final LabelTheme theme;

}

class ExpansionLabelLayoutDelegate extends MultiChildLayoutDelegate {

  ExpansionLabelLayoutDelegate({
    required this.children,
    required this.optionedColumn,
    required this.animationValue,
    required LabelTheme theme}) {
    ids = getLayoutIds(children);

    rowCount = theme.rowCount;
    visibleColumn = theme.visibleColumn;
    spacing = theme.spacing;
    labelHeight = theme.labelHeight;

    columnCount = getColumnCount();

  }

  List<Widget> children;
  late int rowCount;
  late int visibleColumn;
  late double labelWidth;
  late double labelHeight;
  late double spacing;
  late int columnCount;
  late List<int> ids;

  int optionedColumn;

  double animationValue;

  /// 向上取整计算行数
  int getColumnCount() {
    return (children.length / rowCount).ceil();
  }

  getLayoutIds(List<Widget> children) {
    return children.map((e) {
      return (e as LayoutId).id as int;
    }).toList();
  }

  @override
  Size getSize(BoxConstraints constraints) {
    labelWidth = (constraints.maxWidth - (rowCount * spacing - spacing)) / rowCount;
//    double height = (columnCount * labelHeight + columnCount * spacing - spacing) * animationValue;
    double visibleHeight = visibleColumn * labelHeight + visibleColumn * spacing - spacing;
    double goneHeight = (columnCount - visibleColumn) * labelHeight + (columnCount - visibleColumn) * spacing;
    double height = visibleHeight + goneHeight * animationValue;
    return constraints.constrainDimensions(double.infinity, height);
  }

  @override
  void performLayout(Size size) {

    double xOffset;
    double? yOffset;
    int column = -1;

    double y;

    for (int i = 0; i < ids.length; i++) {
      int id = ids[i];
      if (hasChild(id)) {
        Size childSize = layoutChild(id, BoxConstraints(minWidth: labelWidth, minHeight: labelHeight));
        if (i % rowCount == 0) {
          xOffset = 0;
          column ++;
          yOffset = (column * spacing);
        } else {
          int rowIndex = (i % rowCount);
          xOffset = rowIndex * labelWidth + rowIndex * spacing ;
        }
        double offsetHeight = getOffsetHeight(optionedColumn);
        y = animationValue * offsetHeight - offsetHeight;
        positionChild(id, Offset(xOffset, childSize.height * column + yOffset! + y));
      }
    }
  }

  /// 行数对应顶部距离
  /// 行数从零开始
  double getOffsetHeight(int optionedColumn) {
    if (optionedColumn == 0) return 0;
    int column = optionedColumn - (this.visibleColumn - 1);
    return column * labelHeight + column * spacing;
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return true;
  }

}

