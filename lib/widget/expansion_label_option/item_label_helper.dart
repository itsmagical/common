import 'package:flutter/material.dart';
import 'item_label.dart';
import 'item_entity.dart';
import 'label_theme.dart';

class ItemLabelHelper {

  ItemLabelHelper({
    this.onOptionedCallback,
    this.theme
  }) {
    resetOptionedIndex();
  }

  List<ItemEntity> _itemEntities;

  Function onOptionedCallback;

  LabelTheme theme;

  List<Widget> itemWidgets;

  int optionedIndex;

  /// 确定位置的label index
  int positionOptionedIndex;

  /// 选中label所在行数
  int optionedColumn = 0;

  void resetOptionedIndex() {
    if (theme.optionedIndex != optionedIndex) {
      optionedIndex = theme.optionedIndex;
      positionOptionedIndex = optionedIndex;
      _setOptioned();
    }
  }

  void _setOptioned() {
    if (_itemEntities != null)
    onOptionedCallback(_itemEntities[optionedIndex], false);
  }

  void setOptionBeans(List<ItemEntity> entities) {
    _itemEntities = entities;
    /// 设置的可见行数不能大于数据行数
    int columnCount = getColumnCount();
    if (theme.visibleColumn > columnCount) {
      theme.visibleColumn = columnCount;
    }

    if (theme.optionedIndex >= _itemEntities.length) {
      theme.optionedIndex = _itemEntities.length - 1;
      if (theme.optionedIndex < 0) {
        theme.optionedIndex = null;
      }

      optionedIndex = theme.optionedIndex;
      positionOptionedIndex = optionedIndex;
    }

    _setOptioned();
  }

  List<ItemEntity> getOptionBean() {
    return _itemEntities;
  }

  void createItemWidgets(List<ItemEntity> beans) {
    itemWidgets = [];
    for (int i = 0; i < beans.length; i++) {
      itemWidgets.add(createItemWidget(i, beans[i]));
    }
  }

  Widget createItemWidget(int id, ItemEntity entity) {

    bool isOptioned = optionedIndex == id;

    return LayoutId(
      id: id,
      child: ItemLabel(
        index: id,
        isOptioned: isOptioned,
        entity: entity,
        theme: theme,
        optionedCallback: (bean, index) {
          optionedIndex = index;
          // optionedColumn = calcOptionedColumn(index);
          onOptionedCallback(bean, true);
        },
      ),
    );
  }

  /// 选中的label所在行数
  /// 从零行开始计算
  int calcOptionedColumn(int index) {
    return (index / theme.rowCount).floor();
  }

  List<Widget> getItemWidgets() {
    createItemWidgets(_itemEntities);
    return itemWidgets;
  }

  int getOptionedColumn() {
    if(positionOptionedIndex != null) {
      optionedColumn = calcOptionedColumn(positionOptionedIndex);
    }
    return optionedColumn;
  }

  void setPositionOptionedIndex() {
    positionOptionedIndex = optionedIndex;
  }

  /// 向上取整计算行数
  int getColumnCount() {
    return (_itemEntities.length / theme.rowCount).ceil();
  }

}