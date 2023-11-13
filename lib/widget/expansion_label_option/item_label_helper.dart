import 'package:common/util/util.dart';
import 'package:common/widget/expansion_label_option/option_controller.dart';
import 'package:flutter/material.dart';
import 'item_label.dart';
import 'item_entity.dart';
import 'label_theme.dart';

class ItemLabelHelper {

  ItemLabelHelper({
    required this.optionController,
    required this.onOptionedCallback,
    required this.theme
  }) {
    optionedIndexes = [];
    resetOptionedIndex();
  }

  OptionController optionController;

  List<ItemEntity> _itemEntities = [];

  Function onOptionedCallback;

  LabelTheme theme;

  late List<Widget> itemWidgets;

  int? optionedIndex;

  late List<int> optionedIndexes;

  /// 确定位置的label index
  int? positionOptionedIndex;

  /// 选中label所在行数
  int optionedColumn = 0;

  void resetOptionedIndex() {
    if (optionController.optionedIndex != optionedIndex || theme.isMultiple) {
      optionedIndex = optionController.optionedIndex;
      positionOptionedIndex = optionedIndex;

      optionedIndexes.clear();
      optionedIndexes.add(optionedIndex!);
      _setOptioned();
    }
  }

  void _setOptioned() {
    ItemEntity? itemEntity;
    if (_itemEntities != null && _itemEntities.length > 0) {
      itemEntity = optionedIndex != null ? _itemEntities[optionedIndex!] : null;
      onOptionedCallback(itemEntity, optionedIndex, false);
    }
  }

  void setOptionEntities(List<ItemEntity> entities) {
    if (entities.isEmpty) {
      return;
    }
    _itemEntities = entities;
    /// 设置的可见行数不能大于数据行数
    int columnCount = getColumnCount();
    if (theme.visibleColumn > columnCount) {
      theme.visibleColumn = columnCount;
    }

    if (optionController.optionedIndex != null && optionController.optionedIndex! >= _itemEntities.length) {
      optionController.optionedIndex = _itemEntities.length - 1;
      if (optionController.optionedIndex! < 0) {
        optionController.optionedIndex = null;
      }

      optionedIndex = optionController.optionedIndex!;
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

    if (theme.isMultiple) {
      isOptioned = optionedIndexes.contains(id);
    }

    return LayoutId(
      id: id,
      child: ItemLabel(
        index: id,
        isOptioned: isOptioned,
        entity: entity,
        theme: theme,
        optionedCallback: (bean, index) {
          if (theme.isMultiple) {
            if (optionedIndexes.contains(index)) {
              optionedIndexes.remove(index);
              if (Util.isNotEmpty(optionedIndexes)) {
                optionedIndex = optionedIndexes.last;
              }
            } else {
              optionedIndex = index;
              optionedIndexes.add(index);
            }
          } else {
            optionedIndex = index;
          }
          // optionedColumn = calcOptionedColumn(index);
          onOptionedCallback(bean, index, true);
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
      optionedColumn = calcOptionedColumn(positionOptionedIndex!);
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