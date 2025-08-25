import 'package:flutter/material.dart';
import 'package:my_day_flow/core/constants/colors.dart';

ThemeData myTheme = ThemeData(
  switchTheme: SwitchThemeData(
    trackOutlineColor: WidgetStatePropertyAll(AppColors.transparent),
    trackColor: WidgetStatePropertyAll(AppColors.white),
    thumbColor: WidgetStatePropertyAll(AppColors.blueDeep),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white, // This will make the drawer icon white
    ),
  ),

  // fontFamily: 'montaga',
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
);
