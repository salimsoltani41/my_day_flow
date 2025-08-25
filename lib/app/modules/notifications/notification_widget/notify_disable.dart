import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_day_flow/app/modules/notifications/notification_controller.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/glass_container.dart';

/// Widget to display and toggle the global notification status.
/// - Shows a notification icon inside a colored circle.
/// - Displays label text based on whether notifications are enabled.
/// - Provides a switch to toggle notification state.
class NotificationStatus extends GetView<NotificationController> {
  const NotificationStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Notification icon with red gradient background
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              gradient: AppGradient.redGradient.scale(0.8),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(Iconsax.notification, color: AppColors.white),
          ),

          /// Toggle label text (Enable/Disable Notifications)
          Obx(
            () => Text(
              controller.enabledNotifications.value
                  ? AppStrings.disableNotify
                  : AppStrings.enableNotify,
              style: AppTextStyles.body(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// Switch to enable/disable notifications
          Obx(
            () => Switch(
              value: controller.enabledNotifications.value,
              onChanged: controller.toggleNotification,
              activeColor: AppColors.blueDeep,
              activeTrackColor: AppColors.white.withValues(alpha: 0.8),
              inactiveTrackColor: AppColors.lightGrey.withValues(alpha: 0.6),
              inactiveThumbColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
