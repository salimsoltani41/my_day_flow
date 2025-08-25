import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:my_day_flow/app/data/models/habit_model.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/habits_controller.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';

/// A widget for selecting repetition days of a habit.
///
/// Depending on the selected [FrequencyType] (daily, weekly, monthly),
/// it shows different UI options:
///
/// - **Daily** → Displays simple text: "Repeats every day".
/// - **Weekly** → Displays selectable weekday chips.
/// - **Monthly** → Provides a text field to enter the day of the month.
class WeekDaySelector extends GetView<HabitsController> {
  const WeekDaySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final freq = controller.frequency.value;

      // DAILY frequency → No selection needed
      if (freq == FrequencyType.daily) {
        return Text('Repeats every day', style: AppTextStyles.body());
      }
      // WEEKLY frequency → User selects weekdays
      else if (freq == FrequencyType.weekly) {
        return Wrap(
          spacing: 8,
          children: List.generate(7, (i) {
            final dayIndex = i; // Day index (0 = Monday, 6 = Sunday)
            final selected = controller.selectedWeekDays.contains(dayIndex);

            return ChoiceChip(
              label: Text(controller.weekdays[i]),
              selected: selected,
              onSelected: (_) => controller.toggleWeekDay(dayIndex),
            );
          }),
        );
      }
      // MONTHLY frequency → User selects day of month
      else {
        return Row(
          children: [
            Text('Day of month: ', style: AppTextStyles.body()),
            SizedBox(
              width: 80,
              child: TextFormField(
                style: AppTextStyles.body(),
                initialValue: controller.dayOfMonth.value.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: '1-31'),
                onChanged: (s) {
                  final n = int.tryParse(s) ?? 1;
                  controller.setDayOfMonth(n);
                },
              ),
            ),
          ],
        );
      }
    });
  }
}
