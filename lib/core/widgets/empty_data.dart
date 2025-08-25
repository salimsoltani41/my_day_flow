import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_day_flow/core/constants/images.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(AnimationName.noData, height: 160, width: 160),
          Text(AppStrings.emptyData, style: AppTextStyles.body()),
        ],
      ),
    );
  }
}
