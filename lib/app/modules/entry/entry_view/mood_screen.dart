import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/mood_controller.dart';
import 'package:my_day_flow/app/modules/entry/entry_models/mood_list_model.dart';
import 'package:my_day_flow/app/modules/entry/entry_widgets/mood_selector.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/custom_button.dart';

/// Mood Details Screen
///
/// This screen allows the user to select a mood from [MoodSelector].
/// Once selected, a description and a tip related to the mood
/// are displayed below the selector.
///
/// Controlled by [MoodController].
class MoodDetailsScreen extends GetView<MoodController> {
  const MoodDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,

      // BODY ===============================================================
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            // MOOD SELECTION GRID ==========================================
            const Expanded(child: MoodSelector()),

            // SELECTED MOOD DESCRIPTION ===================================
            Obx(() {
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: controller.selectedMood.value != -1
                    ? _buildMoodDescription(controller.selectedMood.value)
                    : const SizedBox(),
              );
            }),
          ],
        ),
      ),

      // SAVE BUTTON (Bottom Navigation Bar) ================================
      bottomNavigationBar: MyButton(
        onTap: controller.addMood,
        text: 'Save',
        buttonGradient: AppGradient.blueGradient,
      ),
    );
  }

  /// Builds the mood description and tip container
  /// based on the selected mood index.
  Widget _buildMoodDescription(int moodIndex) {
    if (moodIndex < 0 || moodIndex >= moods.length) return const SizedBox();

    final selectedMood = moods[moodIndex];
    final descriptions = _getShortDescriptions();
    final moodData = descriptions[selectedMood.title] ?? _getDefaultMood();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // DESCRIPTION PAGE
          _buildMoodPage(
            title: selectedMood.title,
            content: moodData['description']!,
          ),

          const SizedBox(height: 10),

          // TIP PAGE
          _buildMoodPage(title: 'Tip', content: moodData['tip']!),
        ],
      ),
    );
  }

  /// Helper widget to display a mood page
  /// (title + short content text).
  Widget _buildMoodPage({required String title, required String content}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: AppTextStyles.headline(fontSize: 16)),
        const SizedBox(height: 4),
        Text(
          content,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.body(
            fontSize: 16,
          ).copyWith(color: AppColors.white.withAlpha(200)),
        ),
      ],
    );
  }

  /// Provides short descriptions and tips for moods
  Map<String, Map<String, String>> _getShortDescriptions() {
    return {
      'Happy': {'description': 'Positive energy!', 'tip': 'Share your joy'},
      'Sad': {'description': 'Emotions are valid', 'tip': 'Talk to someone'},
      'Neutral': {'description': 'Balanced today', 'tip': 'Time to reflect'},
      'Angry': {'description': 'Strong feelings', 'tip': 'Deep breaths help'},
      'Stressed': {'description': 'Feeling overwhelmed', 'tip': 'Take breaks'},
      'Loved': {'description': 'Feeling cherished', 'tip': 'Show gratitude'},
    };
  }

  /// Default fallback mood data
  Map<String, String> _getDefaultMood() {
    return {'description': 'Thanks for sharing', 'tip': 'You matter'};
  }
}
