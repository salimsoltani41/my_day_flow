import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/home/home_class/frequency_convert.dart';
import 'package:my_day_flow/app/modules/home/home_controller.dart';
import 'package:my_day_flow/app/modules/home/home_widgets/daily_mood.dart';
import 'package:my_day_flow/app/modules/home/home_widgets/glass_card.dart';
import 'package:my_day_flow/app/modules/home/home_widgets/quote_banner.dart';
import 'package:my_day_flow/app/modules/quotes/quote_controller.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/my_data_handling.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

/// Current Habits View - Displays active habits with optional quote and mood
class MyCurrentView extends GetView<HomeController> {
  const MyCurrentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => SmartRefresher(
        header: const WaterDropHeader(),
        controller: controller.currentHabitsRefreshController,
        onRefresh: controller.refreshBothTabs,
        child: Column(
          children: [
            // Show quote OR mood based on availability - no animation errors
            _buildHeaderContent(),

            // Active habits title
            Text(AppStrings.activeHabits, style: AppTextStyles.headline()),
            const SizedBox(height: 10),

            // Habits list
            Expanded(
              child: MyDataHandling(
                requestStatus: controller.myRequestCurrent,
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.currentHabits.length,
                    itemBuilder: (context, index) {
                      final habit = controller.currentHabits[index];
                      return GlassmorphismHabitCard(
                        completeText: AppStrings.complete,
                        onComplete: (context) =>
                            controller.toggleHabitCompletion(habit.id, true),
                        onDelete: (context) =>
                            controller.cofirmDelete(false, habit.id),
                        habitName: habit.habit,
                        time: controller.getTime(habit.time),
                        frequency: FrequencyConverter.convertToFrequency(habit),
                        habitColor: LinearGradient.lerp(
                          controller.strToGradient(habit.color),
                          AppGradient.blackGradient,
                          0.3,
                        )!,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build header content - quote banner OR compact mood (no fixed height)
  Widget _buildHeaderContent() {
    return Obx(() {
      final quoteController = Get.find<QuoteController>();

      // Check if we should show quote
      final hasQuote =
          quoteController.enableQuotes.value &&
          quoteController.currentQuote.value != null;

      if (hasQuote && controller.showQuote.value) {
        // Show quote banner (takes its natural height ~150px)
        return Column(
          children: [buildQuoteBanner(), const SizedBox(height: 16)],
        );
      } else {
        // Show compact mood only (takes its natural height ~80px)
        return Column(
          children: [
            SizedBox(
              height: 110, // Fixed compact height for mood
              child: buildDailyMoodGlass(
                icon: controller.myMood?.icon,
                color: controller.myMood?.iconColor,
                mood: controller.myMood?.title,
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      }
    });
  }
}
