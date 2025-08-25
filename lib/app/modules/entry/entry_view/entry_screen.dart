import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/entry_controller.dart';
import 'package:my_day_flow/app/modules/entry/entry_view/habits_screen.dart';
import 'package:my_day_flow/app/modules/entry/entry_view/mood_screen.dart';
import 'package:my_day_flow/app/modules/entry/entry_widgets/entry_type_toggle.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';

/// Add Entry Screen
///
/// Parent screen that allows the user to add either:
/// - A **Habit** entry
/// - A **Mood** entry
///
/// Controlled by [EntryController] which handles the toggle state.
/// Uses [EntryTypeToggle] to switch between "Habit" and "Mood".
class AddEntryScreen extends GetView<EntryController> {
  const AddEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR ============================================================
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blueDeep,
        title: Text('Add Entry', style: AppTextStyles.headline()),
      ),

      // BODY ==============================================================
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          gradient: AppGradient.backgroundGradient, // Gradient background
        ),
        child: Column(
          children: [
            // TOGGLE SECTION (Switch between Habit/Mood) ===================
            const EntryTypeToggle(),

            const SizedBox(height: 10),

            // MAIN CONTENT (HabitDetails or MoodDetails) ===================
            Expanded(
              child: Obx(
                () => controller.isMood.value
                    ? const MoodDetailsScreen() // If isMood = true → show Mood
                    : const HabitDetailsScreen(), // Else → show Habit
              ),
            ),
          ],
        ),
      ),
    );
  }
}
