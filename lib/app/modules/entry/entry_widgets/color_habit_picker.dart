import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/habits_controller.dart';
import 'package:my_day_flow/app/modules/entry/entry_models/habit_color_model.dart';
import 'package:my_day_flow/core/constants/colors.dart';

/// A dropdown color picker widget for selecting a habit color.
///
/// Uses GetX's [HabitsController] to:
/// - Display the currently selected color.
/// - Allow the user to change it.
/// - Update the controller's state accordingly.
class ColorHabitPicker extends GetView<HabitsController> {
  const ColorHabitPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),

      // Reactive dropdown using Obx → rebuilds whenever selectedColor changes
      child: Obx(
        () => DropdownButton<MyHabitColors>(
          isExpanded: true, // Full width
          value: controller.selectedColor!.value, // Current selected color
          iconEnabledColor: AppColors.blue, // Icon color
          iconSize: 30, // Dropdown arrow size
          dropdownColor: const Color.fromARGB(255, 237, 237, 237),

          // Dropdown items: list of all available habit colors
          items: colors.map((colorItem) {
            return DropdownMenuItem<MyHabitColors>(
              value: colorItem,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: colorItem.color.scale(0.90), // Apply gradient
                ),
                child: Text(
                  colorItem.id, // Display color ID/name
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),

          // When user selects a color → update controller
          onChanged: (selected) {
            if (selected != null) {
              controller.pickColor(selected);
            }
          },
        ),
      ),
    );
  }
}
