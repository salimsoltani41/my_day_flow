import 'package:flutter/material.dart';
import 'package:my_day_flow/app/modules/home/home_controller.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';

/// A custom navigation drawer widget for the MyDayFlow application.
///
/// This drawer provides easy access to main app features and navigation options.
/// It features a gradient header with the app menu title and a dynamic list
/// of menu items that are generated from the HomeController's menuItems list.
///
/// The drawer is responsive and adjusts its width based on screen size.
class MyDrawer extends StatelessWidget {
  /// Controller that provides menu items data and handles navigation logic
  final HomeController controller;

  const MyDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      // Set drawer background to white for clean appearance
      backgroundColor: Colors.white,

      // Responsive width: approximately 60% of screen width
      // This provides good balance between content visibility and usability
      width: screenWidth / 1.7,

      child: Column(
        children: [
          // === HEADER SECTION ===
          // Gradient header container that displays the menu title
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 120, // Fixed height for consistent header size
            // Apply app's signature gradient background
            decoration: const BoxDecoration(
              gradient: AppGradient.backgroundGradient,
            ),

            child: Text(AppStrings.menu, style: AppTextStyles.headline()),
          ),

          // Spacing between header and menu items
          const SizedBox(height: 20),

          // === MENU ITEMS SECTION ===
          // Dynamically generate menu items from controller data
          // Using spread operator (...) to flatten the list into the Column
          ...List.generate(controller.menuItems.length, (index) {
            // Get current menu item for cleaner code
            final menuItem = controller.menuItems[index];

            return InkWell(
              onTap: menuItem.onTap,

              // Add subtle visual feedback on tap
              splashColor: AppColors.darkBlue.withOpacity(0.1),
              highlightColor: AppColors.darkBlue.withOpacity(0.05),

              child: Container(
                // Consistent padding for touch-friendly targets
                padding: const EdgeInsets.symmetric(
                  horizontal: 25, // Horizontal padding for visual spacing
                  vertical: 15, // Vertical padding for easy tapping
                ),

                child: Row(
                  children: [
                    // Menu item icon
                    Icon(
                      menuItem.icon,
                      size: 30, // Large enough for easy recognition
                      color: AppColors.darkBlue, // Consistent with app theme
                    ),

                    // Spacing between icon and text
                    const SizedBox(width: 10),

                    // Menu item title text
                    Text(
                      menuItem.title,
                      style: AppTextStyles.body(color: AppColors.darkBlue),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
