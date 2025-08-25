import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_day_flow/app/modules/entry/entry_controller/habits_controller.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';

/// A widget that shows a toggle switch for enabling or disabling reminders.
///
/// This widget listens to the [HabitsController] using GetX's reactivity.
/// It displays a label ("Reminder") and a switch that allows the user to
/// turn reminders on or off.
class ReminderToggle extends GetView<HabitsController> {
  const ReminderToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Space out text and switch
      children: [
        /// Reminder label
        Text(AppStrings.reminder, style: AppTextStyles.headline(fontSize: 18)),

        /// Reactive switch - updates when [isReminder] changes
        Obx(
          () => Switch(
            inactiveThumbColor: AppColors.lightGrey,
            value: controller.isReminder.value, // Bound to the controller state
            onChanged: (val) =>
                controller.toggleReminder(val), // Updates state on toggle
          ),
        ),
      ],
    );
  }
}
