import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_day_flow/app/modules/auth/login/login_widgets/auth_logo.dart';
import 'package:my_day_flow/app/modules/home/home_controller.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';

/// Custom AppBar widget for the Home screen that includes both a title and tab navigation
///
/// This widget serves as the main header for the home screen, featuring:
/// - App name title in the center
/// - Two tabs: "Current" and "Completed" tasks
/// - Custom styling with dark blue background and white indicators
///
/// Implements [PreferredSizeWidget] to define custom height for the AppBar
class HeaderHome extends GetView<HomeController>
    implements PreferredSizeWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Center the app title in the AppBar
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TODO: Uncomment when logo is ready
          AuthLogo(height: 50, width: 50),

          SizedBox(width: 10),

          // Display app name with custom styling
          Text(AppStrings.appName, style: AppTextStyles.headline()),
        ],
      ),

      // Set AppBar background color to match app theme
      backgroundColor: AppColors.darkBlue,

      // Add TabBar at the bottom of the AppBar
      bottom: TabBar(
        // Use the tab controller from HomeController for state management
        controller: controller.tabController,

        // Tab indicator settings
        indicatorSize: TabBarIndicatorSize.tab, // Full width indicator
        indicatorColor: AppColors.white, // White indicator line
        // Tab label colors
        labelColor: AppColors.white, // Active tab text color
        unselectedLabelColor: AppColors.lightGrey, // Inactive tab text color

        tabs: [
          // First Tab: Current Tasks
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min, // Take minimum required space
              children: [
                const Icon(
                  Icons.sports_gymnastics_outlined,
                ), // Current tasks icon
                const SizedBox(width: 10), // Spacing between icon and text
                Text(AppStrings.current), // "Current" tab label
              ],
            ),
          ),

          // Second Tab: Completed Tasks
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min, // Take minimum required space
              children: [
                const Icon(Icons.check_circle), // Completed tasks icon
                const SizedBox(width: 10), // Spacing between icon and text
                Text(AppStrings.completed), // "Completed" tab label
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => controller.confirmSignOut(),
          icon: Icon(Iconsax.logout),
        ),
      ],
    );
  }

  /// Define the preferred size for this AppBar
  ///
  /// Returns the total height needed for both the AppBar and TabBar:
  /// - kToolbarHeight: Standard AppBar height (56.0 dp)
  /// - kTextTabBarHeight: Standard TabBar height (48.0 dp)
  /// - Total height: 104.0 dp
  @override
  Size get preferredSize => const Size.fromHeight(
    kToolbarHeight + // AppBar height (56.0 dp)
        kTextTabBarHeight, // TabBar height (48.0 dp)
  ); // Total: 104.0 dp
}
