import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/habits_controller.dart';
import 'package:my_day_flow/core/constants/colors.dart';

/// A widget for picking and displaying a habit time.
///
/// - Uses [GetX] for reactive state management.
/// - Displays the selected time inside a styled [ListTile].
/// - Opens a time picker when tapped.
class TimeHabitPicker extends GetView<HabitsController> {
  const TimeHabitPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.white, // background color from your constants
          borderRadius: BorderRadius.circular(10), // rounded corners
        ),
        child: ListTile(
          leading: const Icon(Icons.access_time), // time icon
          title: Text(
            // Display the selected time in a formatted way
            'Time: ${controller.time.value.format(context)}',
          ),
          // When tapped, open the time picker from the controller
          onTap: () => controller.pickTime(context),
        ),
      ),
    );
  }
}
