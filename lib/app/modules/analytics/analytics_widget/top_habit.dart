import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/widgets/glass_container.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_controller.dart';
import 'package:my_day_flow/core/constants/colors.dart';

/// A widget that displays the user's **Top Habits** in the monthly report.
///
/// Shows a header, followed by a list of ranked habits with:
/// - A position badge (gold, silver, bronze, or purple)
/// - The habit name
/// - Completion stats (rate %, completed/total days)
/// - A progress bar indicating completion percentage
class TopHabitsWidget extends GetView<AnalyticsController> {
  const TopHabitsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----- Header -----
          Row(
            children: const [
              Icon(Icons.trending_up, color: Colors.tealAccent, size: 24),
              SizedBox(width: 12),
              Text(
                AppStrings.topHabits,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ----- Habits List -----
          ...controller.topPerformingHabits!.asMap().entries.map((entry) {
            final index = entry.key;
            final habit = entry.value;
            return _buildHabitCard(habit, index);
          }).toList(),
        ],
      ),
    );
  }

  /// Builds a habit card with ranking, stats, and a progress bar.
  Widget _buildHabitCard(habit, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withAlpha(70)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // ----- Position Badge -----
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _getBadgeColor(index),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: _getBadgeTextColor(index),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // ----- Habit Name -----
              Expanded(
                child: Text(
                  habit.habitName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // ----- Stats (Completion Rate + Days) -----
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${(habit.completionRate * 100).round()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${habit.completedDays}/${habit.totalDays} days',
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ----- Progress Bar -----
          _buildProgressBar(habit.completionRate),
        ],
      ),
    );
  }

  /// Builds a progress bar showing the habit's completion percentage.
  Widget _buildProgressBar(double completionRate) {
    return Container(
      width: double.infinity,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(6),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: completionRate, // scales bar by % (0.0 - 1.0)
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.teal, AppColors.blue]),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  /// Returns badge background color based on rank.
  Color _getBadgeColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFDD835); // Gold
      case 1:
        return const Color(0xFF9E9E9E); // Silver
      case 2:
        return const Color(0xFFFF8A65); // Bronze
      default:
        return const Color(0xFF8B5CF6); // Purple for others
    }
  }

  /// Returns text color for the badge to ensure good contrast.
  Color _getBadgeTextColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFF5D4037); // Dark brown for gold
      case 1:
        return const Color(0xFF424242); // Dark gray for silver
      case 2:
        return const Color(0xFFBF360C); // Dark orange for bronze
      default:
        return Colors.white; // White for purple
    }
  }
}
