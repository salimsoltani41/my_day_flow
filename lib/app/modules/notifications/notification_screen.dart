import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_day_flow/app/modules/notifications/notification_controller.dart';
import 'package:my_day_flow/app/modules/notifications/notification_widget/notify_disable.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/glass_container.dart';
import 'package:my_day_flow/core/widgets/my_data_handling.dart';

/// Screen that allows users to manage notification settings.
/// - Displays general notification status (enabled/disabled).
/// - Lists all habits with individual notification toggles.
/// - Provides contextual hints about how notifications work.
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// --- AppBar ---
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blueDeep,
        title: Text(AppStrings.notification, style: AppTextStyles.headline()),
      ),

      /// --- Body with gradient background ---
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppGradient.backgroundGradient),

        /// Rebuilds UI when NotificationController state changes
        child: GetBuilder<NotificationController>(
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///  Global notification status (enabled/disabled)
              NotificationStatus(),
              const SizedBox(height: 15),

              ///  Section Header: Individual habit notifications
              Row(
                children: [
                  const Icon(Iconsax.setting_3, color: AppColors.white),
                  const SizedBox(width: 15),
                  Text(AppStrings.indivHabits, style: AppTextStyles.headline()),
                ],
              ),
              Text(
                AppStrings.toggleNotifyDesc,
                style: AppTextStyles.body(color: AppColors.lightGrey),
              ),
              const SizedBox(height: 15),

              ///  Scrollable list of habits with toggle switches
              Expanded(
                child: MyDataHandling(
                  requestStatus: controller.homeController.myRequestCurrent,
                  child: ListView.builder(
                    itemCount: controller.currentHabits.length,
                    itemBuilder: (context, index) {
                      final habit = controller.currentHabits[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: GlassContainer(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              /// Habit color indicator (circle)
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: controller.homeController
                                      .strToGradient(habit.color),
                                ),
                              ),
                              const SizedBox(width: 10),

                              /// Habit title + reminder time
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    habit.habit,
                                    style: AppTextStyles.body(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${AppStrings.reminderAt}: ${controller.homeController.getTime(habit.time)}',
                                    style: AppTextStyles.body(
                                      color: AppColors.white.withAlpha(200),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),

                              /// Notification toggle switch for this habit
                              Switch(
                                activeTrackColor: AppColors.white.withValues(
                                  alpha: 0.8,
                                ),
                                inactiveTrackColor: AppColors.lightGrey
                                    .withValues(alpha: 0.6),
                                inactiveThumbColor: AppColors.white,
                                value: controller.getHabitNotificationStatus(
                                  habit.id,
                                ),
                                onChanged: (val) => controller
                                    .toggleNotificationByHabit(habit.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              /// Informational text at bottom
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    AppStrings.bottomNotifyObserv,
                    style: AppTextStyles.body(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
