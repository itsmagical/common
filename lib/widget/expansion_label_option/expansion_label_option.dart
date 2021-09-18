import 'package:flutter/material.dart';
import 'expansion_label_layout.dart';
import 'item_label_helper.dart';
import 'item_entity.dart';
import 'label_theme.dart';
import 'dart:math' as math;

import 'option_controller.dart';

typedef OptionedCallback<T> = void Function(T entity, int index);

/// 可折叠的标签选择器
/// 支持自定义列数和默认显示行数
/// 数据Model需实现 LabelOptionBean接口
/// @author LiuHe
/// @created at 2020/11/23 15:43

class ExpansionLabelOption extends StatefulWidget {

  ExpansionLabelOption({
    this.width,
    this.theme,
    this.optionController,
    @required this.itemEntities,
    @required this.onOptionedCallback,
  });

  /// 自身宽度 默认最大宽度
  final int width;

  final LabelTheme theme;

  final OptionController optionController;

  /// 数据源
  final List<ItemEntity> itemEntities;

  /// 选中回调
  final OptionedCallback<ItemEntity> onOptionedCallback;

  @override
  State<StatefulWidget> createState() {
    return _ExpansionLabelOptionState(theme);
  }

}

class _ExpansionLabelOptionState extends State<ExpansionLabelOption> with SingleTickerProviderStateMixin {

  _ExpansionLabelOptionState(LabelTheme theme) {
    this.theme = theme != null ? theme : LabelTheme();
  }

  LabelTheme theme;
  AnimationController controller;
  Animation animation;

  ItemLabelHelper labelHelper;

  @override
  void initState() {
    controller = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    animation = Tween(begin: 0.0, end: 1).animate(controller);

    OptionController optionController = widget.optionController ?? OptionController(initOptionedIndex: 0);

    labelHelper = ItemLabelHelper(onOptionedCallback: onOptionedCallback, theme: theme, optionController: optionController);

    if (isNotEmpty(widget.itemEntities)) {
      labelHelper.setOptionEntities(widget.itemEntities);
    }

    if (widget.optionController != null) {
      widget.optionController.setStateCallback(setStateCallback);
      widget.optionController.setOptionedIndexCallback(labelHelper.resetOptionedIndex);
    }

    super.initState();
  }

  @override
  void didUpdateWidget(ExpansionLabelOption oldWidget) {
    /// 为解决点击重复回调问题，暂时设置只能设置一次数据源，setState后数据不变
    if (isNotEmpty(widget.itemEntities) && !isNotEmpty(labelHelper.getOptionBean())) {
      labelHelper.setOptionEntities(widget.itemEntities);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: isNotEmpty(widget.itemEntities) ? AnimatedBuilder(
          animation: animation,
          builder: buildExpansionLabelLayout
      ) : Container(),
    );
  }

  Widget buildExpansionLabelLayout(context, child) {

    return Container(
      child: Column(
        children: <Widget>[
          ClipRect(
            child: ExpansionLabelLayout(
              children: labelHelper.getItemWidgets(),
              optionedColumn: labelHelper.getOptionedColumn(),
              theme: theme,
              animationValue: controller.value,
            ),
          ),
          Offstage(
            offstage: labelHelper.getColumnCount() <= theme.visibleColumn,
            child: GestureDetector(
              onTap: () {
                double value = controller.value;
                if (value == 0) {
                  controller.forward();
                } else {
                  /// 折叠布局时将选中的label index 作为位置index
                  labelHelper.setPositionOptionedIndex();
                  controller.reverse();
                }
              },
              child: Transform.rotate(
                angle: animation.value * math.pi,
                child: Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFDBDBDB),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Icon(
                    Icons.expand_more,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  onOptionedCallback(ItemEntity entity, int index, bool setState) {
    widget.onOptionedCallback(entity, index);
    if (setState) {
      setStateCallback();
    }
  }

  setStateCallback() {
    setState(() {});
  }

  bool isNotEmpty(Iterable iterable) {
    return null != iterable && iterable.length > 0;
  }

}