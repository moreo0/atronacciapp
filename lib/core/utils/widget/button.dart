import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final Widget widget;
  final double height;
  final double width;
  const Button({
    super.key,
    required this.onPressed,
    required this.color,
    required this.widget,
    this.height = 45.0,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: widget,
      ),
    );
  }
}
