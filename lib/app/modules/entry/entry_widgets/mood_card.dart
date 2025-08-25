import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/mood_controller.dart';
import 'package:my_day_flow/app/modules/entry/entry_models/mood_list_model.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';

/// A card widget that represents a mood option in the mood selector.
///
/// - Displays mood icon and title.
/// - Animates when selected (scale, shadow, border, and color changes).
/// - Uses [MoodController] for reactive state management with GetX.
class MoodCard extends GetView<MoodController> {
  final int index;

  const MoodCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.isTapped(
        index,
      ); // Whether this mood is selected
      final mood = moods[index]; // The mood data for this card

      return AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        height: 50,
        width: 50,
        transform: Matrix4.identity()
          ..scale(isSelected ? 1.1 : 1.0), // Scale up when selected
        child: InkWell(
          onTap: () =>
              controller.tapMood(index, mood.title), // Select mood on tap
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Glass effect
              child: Container(
                decoration: _buildDecoration(isSelected, mood),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_buildIcon(isSelected, mood), _buildTitle(mood)],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  /// Builds the background decoration of the card,
  /// applying dynamic colors, borders, and shadows based on selection state.
  BoxDecoration _buildDecoration(bool isSelected, MoodListModel mood) {
    return BoxDecoration(
      color: isSelected
          ? mood.iconColor.withAlpha(160)
          : mood.iconColor.withAlpha(50),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isSelected ? Colors.white : mood.iconColor,
        width: 2,
      ),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 8),
          blurRadius: isSelected ? 40 : 32,
          spreadRadius: 0,
          color: mood.iconColor.withAlpha(isSelected ? 80 : 40),
        ),
        if (isSelected) ...[
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 20,
            spreadRadius: 2,
            color: mood.iconColor.withAlpha(100),
          ),
          const BoxShadow(
            offset: Offset(-7, 7),
            blurRadius: 10,
            spreadRadius: 5,
            color: AppColors.black,
          ),
        ],
      ],
    );
  }

  /// Builds the mood icon with size and color animations when selected.
  Widget _buildIcon(bool isSelected, MoodListModel mood) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Image.asset(
        mood.icon,
        height: isSelected ? 43 : 36,
        width: isSelected ? 43 : 36,
        color: isSelected ? mood.iconColor : mood.iconColor.withAlpha(200),
      ),
    );
  }

  /// Builds the title text for the mood.
  Widget _buildTitle(MoodListModel mood) {
    return Text(
      mood.title,
      style: AppTextStyles.headline(fontSize: 16).copyWith(color: Colors.white),
    );
  }
}
