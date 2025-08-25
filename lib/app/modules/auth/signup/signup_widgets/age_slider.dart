import 'package:flutter/material.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';

class AgeSlider extends StatelessWidget {
  final double age;
  final void Function(double)? onChanged;
  const AgeSlider({super.key, required this.age, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorTextStyle: AppTextStyles.body(color: AppColors.black),
      ),
      child: Slider(
        label: age.toInt().toString(),
        padding: const EdgeInsets.all(10),
        inactiveColor: AppColors.darkGrey,
        activeColor: AppColors.white,
        min: 14,
        max: 99,
        value: age,
        onChanged: onChanged,
      ),
    );
  }
}
