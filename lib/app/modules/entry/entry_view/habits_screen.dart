import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/habits_controller.dart';
import 'package:my_day_flow/app/modules/entry/entry_widgets/color_habit_picker.dart';
import 'package:my_day_flow/app/modules/entry/entry_widgets/frequency_selector.dart';
import 'package:my_day_flow/app/modules/entry/entry_widgets/reminder_toggle.dart';
import 'package:my_day_flow/app/modules/entry/entry_widgets/time_habit_picker.dart';
import 'package:my_day_flow/app/modules/entry/entry_widgets/weekdays_selector.dart';
import 'package:my_day_flow/app/utils/helpers/validator_textInput.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/widgets/custom_button.dart';
import 'package:my_day_flow/core/widgets/custom_textformfield.dart';
import 'package:my_day_flow/core/widgets/my_data_handling.dart';

/// Habit Details Screen
///
/// This screen is used to add a new habit entry.
/// Includes fields for:
/// - Habit name
/// - Frequency
/// - Weekdays selection
/// - Time picker
/// - Color picker
/// - Reminder toggle
///
/// Controlled by [HabitsController].
class HabitDetailsScreen extends GetView<HabitsController> {
  const HabitDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,

      // BODY ===============================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: MyDataHandling(
          requestStatus: controller.myRequest,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // HABIT NAME FIELD ===========================================
              MyTextFormField(
                controller: controller.habit,
                validator: (val) => validateTextField(val!, 2, 20, 'habit'),
                hint: 'Add Habit name...',
                icon: Icons.monitor_heart,
              ),

              const SizedBox(height: 15),

              // FREQUENCY SELECTOR =========================================
              const FrequencySelector(),

              const SizedBox(height: 10),

              // WEEKDAY SELECTOR ===========================================
              const WeekDaySelector(),

              const SizedBox(height: 10),

              // TIME PICKER ================================================
              const TimeHabitPicker(),

              const SizedBox(height: 15),

              // COLOR PICKER ===============================================
              const ColorHabitPicker(),

              const SizedBox(height: 20),

              // REMINDER TOGGLE ============================================
              const ReminderToggle(),
            ],
          ),
        ),
      ),

      // SAVE BUTTON (Bottom Navigation Bar) ================================
      bottomNavigationBar: MyButton(
        text: 'Save',
        buttonGradient: AppGradient.blueGradient,
        onTap: controller.addNewHabit,
      ),
    );
  }
}
