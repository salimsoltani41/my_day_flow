import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_controller.dart';
import 'package:my_day_flow/core/constants/strings.dart';

/// A row of statistic cards showing user progress.
///
/// Displays three main stats:
/// - ✅ Total completed tasks ("Done")
/// - ❌ Total missed tasks ("Missed")
/// - 🔥 Current streak in days ("Streak")
class StatsBar extends GetView<AnalyticsController> {
  const StatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ----- Total Completed -----
        Expanded(
          child: _buildStatCard(
            title: AppStrings.done,
            value: '${controller.topBarStats!['totalCompleted']}',
            icon: Icons.emoji_events,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF10B981).withAlpha(50),
                const Color(0xFF059669).withAlpha(50),
              ],
            ),
            borderColor: const Color(0xFF10B981).withAlpha(70),
            iconColor: const Color(0xFF6EE7B7),
            titleColor: const Color(0xFF6EE7B7),
          ),
        ),
        const SizedBox(width: 12),

        // ----- Total Missed -----
        Expanded(
          child: _buildStatCard(
            title: AppStrings.missed,
            value: '${controller.topBarStats!['totalMissed']}',
            icon: Icons.calendar_today,
            gradient: LinearGradient(
              colors: [
                const Color(0xFFEF4444).withAlpha(50),
                const Color(0xFFDC2626).withAlpha(50),
              ],
            ),
            borderColor: const Color(0xFFEF4444).withAlpha(70),
            iconColor: const Color(0xFFFC8181),
            titleColor: const Color(0xFFFC8181),
          ),
        ),
        const SizedBox(width: 12),

        // ----- Current Streak -----
        Expanded(
          child: _buildStatCard(
            title: AppStrings.streak,
            value: '${controller.topBarStats!['currentStreak']} days',
            icon: Icons.bolt,
            gradient: LinearGradient(
              colors: [
                const Color(0xFFF59E0B).withAlpha(50),
                const Color(0xFFD97706).withAlpha(50),
              ],
            ),
            borderColor: const Color(0xFFF59E0B).withAlpha(70),
            iconColor: const Color(0xFFFBBF24),
            titleColor: const Color(0xFFFBBF24),
            valueSize: 16, // Slightly smaller text for streak format
          ),
        ),
      ],
    );
  }

  /// Builds an individual statistic card.
  ///
  /// Each card shows:
  /// - An [icon] inside a rounded container
  /// - A [title] with a themed color
  /// - A [value] (number or text)
  ///
  /// Customizations include:
  /// - [gradient] background
  /// - [borderColor] and [iconColor]
  /// - Optional [valueSize] for flexible sizing
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Gradient gradient,
    required Color borderColor,
    required Color iconColor,
    required Color titleColor,
    double valueSize = 16,
  }) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // ----- Icon Box -----
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: iconColor.withAlpha(50),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 10),

          // ----- Title & Value -----
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: valueSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
