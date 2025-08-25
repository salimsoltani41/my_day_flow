import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/home/home_controller.dart';
import 'package:my_day_flow/app/modules/home/home_widgets/glass_card.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/widgets/my_data_handling.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

/// A view that displays all completed habits for the user.
///
/// This widget shows a list of habits that have been marked as completed,
/// allowing users to view their progress and optionally mark habits as incomplete again.
/// Features pull-to-refresh functionality and handles loading states.
class MyCompletedView extends GetView<HomeController> {
  const MyCompletedView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => SmartRefresher(
        header: const WaterDropHeader(),

        // Controller specifically for managing completed habits refresh state
        controller: controller.completedHabitsRefreshController,

        // Callback when user pulls to refresh - refreshes both active and completed tabs
        onRefresh: () => controller.refreshBothTabs(),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: MyDataHandling(
            // Handles loading, error, and empty states for completed habits data
            requestStatus: controller.myRequestCompleted,

            child: Obx(
              // Reactive widget that rebuilds when completedHabits list changes
              () => ListView.builder(
                itemCount: controller.completedHabits.length,
                itemBuilder: (context, index) {
                  // Get the current completed habit from the list
                  final completedHabit = controller.completedHabits[index];

                  return GlassmorphismHabitCard(
                    onDelete: (context) => controller.cofirmDelete(
                      true, // isCompleted = true (since this is completed habits view)
                      completedHabit.id,
                    ),
                    onComplete: (context) => controller.toggleHabitCompletion(
                      completedHabit.id,
                      false, // Set to false to mark as incomplete
                    ),

                    completeText: AppStrings.Incomplete,

                    habitName: completedHabit.habit,

                    isCompleted: true,

                    // Visual styling: blend habit's original color with black for "completed" appearance
                    // Creates a dimmed version of the original color to indicate completion
                    habitColor: LinearGradient.lerp(
                      controller.strToGradient(
                        completedHabit.color,
                      ), // Original habit color
                      AppGradient
                          .blackGradient, // Black gradient for dimming effect
                      0.3, // 30% blend ratio
                    )!,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
