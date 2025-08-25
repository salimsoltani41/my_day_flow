import 'package:flutter/widgets.dart';
import 'package:my_day_flow/core/constants/colors.dart';

class MyHabitColors {
  final String id;
  final LinearGradient color;

  const MyHabitColors({required this.id, required this.color});
}

// List Of Colors
List<MyHabitColors> colors = [
  MyHabitColors(id: 'Green', color: AppGradient.greensGradient),
  MyHabitColors(id: 'Blue', color: AppGradient.blueGradient),
  MyHabitColors(id: 'Red', color: AppGradient.redGradient),
  MyHabitColors(id: 'Purple', color: AppGradient.purpleGradient),
  MyHabitColors(id: 'Amber', color: AppGradient.amberGradient),
  MyHabitColors(id: 'Grey', color: AppGradient.greyGradient),
  MyHabitColors(id: 'Pinky', color: AppGradient.pinkyGradient),
  MyHabitColors(id: 'Orange', color: AppGradient.orangeGradient),
];
