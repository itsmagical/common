import 'package:flutter/material.dart';
import 'label_option_bean.dart';
import 'label_theme.dart';

typedef OptionedCallback = Function(LabelOptionBean bean, int index);

class ItemLabel extends StatefulWidget {

  ItemLabel({
    this.index,
    this.isOptioned,
    this.theme,
    this.bean,
    this.optionedCallback
  });

  final int index;
  final bool isOptioned;
  final LabelTheme theme;
  final LabelOptionBean bean;
  final OptionedCallback optionedCallback;

  @override
  State<StatefulWidget> createState() {
    return _ItemLabelState();
  }

}

class _ItemLabelState extends State<ItemLabel> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isOptioned) {
          widget.optionedCallback(widget.bean, widget.index);
        }
      },
      child: Container(
//        decoration: BoxDecoration(
//            color: widget.isOptioned ? Color(0xFF1B85FF) : Color(0xFFF7F7F7),
//            borderRadius: BorderRadius.circular(4)
//        ),
        decoration: widget.theme.decorationBuilder(widget.isOptioned),
        alignment: Alignment.center,
        child: Text(
          widget.bean.getName(),
          style: TextStyle(
            color: widget.theme.textColorBuilder(widget.isOptioned),
          ),
        ),
      ),
    );
  }

}

