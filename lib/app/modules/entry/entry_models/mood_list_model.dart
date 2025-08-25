import 'package:flutter/material.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/images.dart';

class MoodListModel {
  final String title;
  final String icon;
  final RadialGradient color;
  final Color iconColor;

  const MoodListModel({
    required this.title,
    required this.icon,
    required this.color,
    required this.iconColor,
  });
}

// List for moods you can expand it in future ====================
List<MoodListModel> moods = [
  MoodListModel(
    title: 'Happy',
    icon: ImageName.moodHappy,
    color: AppGradient.amberRadialGradient,
    iconColor: const Color.fromARGB(255, 248, 211, 1),
  ),
  MoodListModel(
    title: 'Sad',
    icon: ImageName.moodSad,
    color: AppGradient.blueRadialGradient,
    iconColor: AppColors.blue,
  ),
  MoodListModel(
    title: 'Neutral',
    icon: ImageName.moodNeutral,
    color: AppGradient.greyRadialGradient,
    iconColor: AppColors.darkGrey,
  ),
  MoodListModel(
    title: 'Angry',
    icon: ImageName.moodAngry,
    color: AppGradient.redRadialGradient,
    iconColor: AppColors.red,
  ),
  MoodListModel(
    title: 'Stressed',
    icon: ImageName.moodStressed,
    color: AppGradient.orangeRadialGradient,
    iconColor: const Color.fromARGB(255, 255, 136, 0),
  ),
  MoodListModel(
    title: 'Loved',
    icon: ImageName.moodLoved,
    color: AppGradient.pinkyRadialGradient,
    iconColor: AppColors.pink,
  ),
];
