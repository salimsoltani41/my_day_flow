import 'package:flutter/material.dart';
import 'package:my_day_flow/core/constants/colors.dart';

class MyCustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  final LinearGradient? background;
  final Color borderColor;
  final double? padding;
  final double? margin;

  const MyCustomContainer({
    this.margin,
    super.key,
    this.height,
    this.width,
    this.borderColor = AppColors.lightGrey,
    required this.child,
    this.background,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin ?? 0),
      height: height,
      width: width,
      padding: EdgeInsets.all(padding ?? 15),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            offset: Offset(3, -5),
            blurRadius: 6,
            spreadRadius: 1,
            color: Theme.of(context).shadowColor,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: background,
      ),
      child: child,
    );
  }
}
