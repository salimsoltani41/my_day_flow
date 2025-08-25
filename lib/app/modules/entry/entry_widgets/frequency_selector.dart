import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/data/models/habit_model.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/habits_controller.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';

/// A dropdown selector widget for choosing habit frequency.
///
/// Uses GetX's `HabitsController` to manage state.
/// The available options come from the [FrequencyType] enum.
class FrequencySelector extends GetView<HabitsController> {
  const FrequencySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label for the dropdown
        Text('Frequency', style: AppTextStyles.body()),

        const SizedBox(height: 10),

        /// Dropdown for selecting frequency
        DropdownButtonFormField<FrequencyType>(
          // Dropdown icon customization
          iconEnabledColor: AppColors.blue,
          iconSize: 30,

          // Input decoration for the dropdown
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: AppColors.white,
            filled: true,
          ),

          // Currently selected value (reactive with GetX)
          value: controller.frequency.value,

          // Dropdown items generated from the enum values
          items: FrequencyType.values.map((f) {
            final text = f.toString().split('.').last.capitalizeFirst!;
            return DropdownMenuItem(value: f, child: Text(text));
          }).toList(),

          // Update the selected value in the controller
          onChanged: (val) {
            if (val != null) controller.setFrequency(val);
          },
        ),
      ],
    );
  }
}
