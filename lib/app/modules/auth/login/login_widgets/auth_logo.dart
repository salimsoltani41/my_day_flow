import 'package:flutter/material.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/images.dart';

class AuthLogo extends StatelessWidget {
  final double? height;
  final double? width;

  const AuthLogo({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      color: AppColors.white,
      ImageName.appLogo,
      width: width ?? 100,
      height: height ?? 100,
    );
  }
}
