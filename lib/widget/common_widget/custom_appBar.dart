import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final Color backgroundColor;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.actions,
    this.onBack,
    this.backgroundColor = Colors.blue, // 默认背景色
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle( color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor, // 允许自定义背景色
      foregroundColor: Colors.white, // 统一返回按钮和标题的颜色
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBack ?? () => Navigator.of(context).pop(),
      )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
