import 'package:flutter/material.dart';
import 'package:my_day_flow/core/constants/colors.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Gradient buttonGradient;
  final double? buttonWidth;
  final void Function(bool)? onHover;
  final bool isColoring;
  final Color? color;
  final Color? border;

  const MyButton({
    super.key,
    this.onTap,
    this.onHover,
    this.color,
    required this.text,
    this.buttonWidth,
    this.isColoring = false,
    required this.buttonGradient,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: onHover,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        width: buttonWidth ?? double.infinity,
        height: 60,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.solid,
              offset: Offset(4, 4),
              blurRadius: 4,
              color: AppColors.black.withAlpha(70),
            ),
          ],
          border: Border.all(color: border ?? AppColors.blue),
          borderRadius: BorderRadius.circular(15),
          gradient: buttonGradient,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: isColoring ? color : AppColors.white,
          ),
        ),
      ),
    );
  }
}
