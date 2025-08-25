import 'package:flutter/material.dart';

import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/images.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/glass_container.dart';

/// Simple daily mood display widget with glassmorphism design
class DailyMoodView extends StatelessWidget {
  final String? mood;
  final String? icon;
  final Color? color;
  final VoidCallback? onTap;

  const DailyMoodView({
    super.key,
    this.mood,
    this.icon,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mood icon with fallback
            Image.asset(
              icon ?? ImageName.moodNeutral,
              height: 40,
              color: color ?? AppColors.lightGrey,
            ),
            const SizedBox(width: 12),

            // Mood text with overflow protection
            Flexible(
              child: Text(
                mood ?? AppStrings.chooseMood,
                style: AppTextStyles.headline(
                  color: color ?? AppColors.lightGrey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Clean version of the original function
Widget buildDailyMoodGlass({
  required String? mood,
  required String? icon,
  required Color? color,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: GlassContainer(
      padding: const EdgeInsets.all(10),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Mood icon
          Image.asset(
            icon ?? ImageName.moodNeutral,
            height: 40,
            color: color ?? AppColors.lightGrey,
          ),
          const SizedBox(width: 12),

          // Mood text
          Flexible(
            child: Text(
              mood ?? AppStrings.chooseMood,
              style: AppTextStyles.headline(
                color: color ?? AppColors.lightGrey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}
