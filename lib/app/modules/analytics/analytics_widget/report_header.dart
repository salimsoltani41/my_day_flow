import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/widgets/glass_container.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_controller.dart';

/// A header widget for the analytics report section.
///
/// Displays:
/// - An icon with a gradient background.
/// - A title ("Monthly Report").
/// - The current month and year ("Month Year Progress").
class ReportHeader extends GetView<AnalyticsController> {
  const ReportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          // ----- Gradient Icon Container -----
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 66, 215, 223),
                  Color.fromARGB(255, 72, 146, 236),
                ],
              ),
            ),
            child: const Icon(Icons.analytics, color: Colors.white, size: 32),
          ),

          const SizedBox(width: 16),

          // ----- Title and Subtitle -----
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppStrings.monthlyReport,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                _getCurrentMonthYear(),
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Returns the current month and year in the format:
  /// "Month Year Progress".
  String _getCurrentMonthYear() {
    final now = DateTime.now();
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[now.month - 1]} ${now.year} Progress';
  }
}
