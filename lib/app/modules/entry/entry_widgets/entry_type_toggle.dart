// ============================================================================
// EntryTypeToggle Widget
// Widget that allows the user to toggle between "Habits" and "Mood" entries.
// Uses GetX for state management with an EntryController.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/entry_controller.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';

class EntryTypeToggle extends GetView<EntryController> {
  const EntryTypeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ---------------- "Habits" Label ----------------
          Text(
            'Habits',
            style: AppTextStyles.headline(
              fontSize: 18,
              color: controller.isMood.value
                  ? AppColors
                        .lightGrey // Disabled state color
                  : AppColors.white, // Active state color
            ),
          ),

          const SizedBox(width: 10),

          // ---------------- Switch Toggle ----------------
          Switch(
            value: controller.isMood.value,
            onChanged: (val) => controller.toggleEntry(val),
          ),

          const SizedBox(width: 10),

          // ---------------- "Mood" Label ----------------
          Text(
            'Mood',
            style: AppTextStyles.headline(
              fontSize: 18,
              color: controller.isMood.value
                  ? AppColors
                        .white // Active state color
                  : AppColors.lightGrey, // Disabled state color
            ),
          ),
        ],
      ),
    );
  }
}
