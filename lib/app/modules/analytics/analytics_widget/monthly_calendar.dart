import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/core/widgets/glass_container.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_controller.dart';

/// A glass-styled calendar widget that shows **monthly habit progress**.
///
/// Features:
/// - Displays weekdays (Mon–Sun).
/// - Renders each day with a completion-based color code:
///   - ✅ Green → Perfect (100%)
///   - 🟡 Yellow → Good (≥ 80%)
///   - 🟠 Orange → Partial (≥ 50%)
///   - ⚪ Light → None (0%)
/// - Adds a "perfect indicator" dot for fully completed days.
/// - Includes a legend at the bottom for clarity.
///
/// This widget depends on [AnalyticsController] for `monthlyData`.
class MonthlyCalendar extends GetView<AnalyticsController> {
  const MonthlyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: const [
              Icon(Icons.calendar_month, color: Color(0xFF60A5FA), size: 24),
              SizedBox(width: 12),
              Text(
                'Monthly Progress',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Weekdays header (Mon–Sun)
          _buildWeekdaysHeader(),
          const SizedBox(height: 12),

          // Calendar grid for days
          _buildCalendarGrid(),
          const SizedBox(height: 20),

          // Completion legend
          _buildLegend(),
        ],
      ),
    );
  }

  /// Builds the weekdays row (Mon–Sun).
  Widget _buildWeekdaysHeader() {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      childAspectRatio: 1,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: weekdays
          .map(
            (day) => Center(
              child: Text(
                day,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  /// Builds the grid for all days in the current month,
  /// pulling progress data from the [AnalyticsController].
  Widget _buildCalendarGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: controller.monthlyCompletionData!.length,
      itemBuilder: (context, index) {
        final dayData = controller.monthlyCompletionData![index];
        final day = dayData.date.day;

        // Calculate completion percentage
        final completionRate = dayData.totalScheduled > 0
            ? dayData.completedCount / dayData.totalScheduled
            : 0.0;

        return _buildCalendarDay(day, completionRate);
      },
    );
  }

  /// Builds a single day cell with completion coloring.
  Widget _buildCalendarDay(int day, double completionRate) {
    // Define base colors depending on completion
    Color bgColor;
    Color borderColor;
    final bool isPerfect = completionRate >= 1.0;

    if (completionRate >= 0.8) {
      bgColor = const Color(0xFF10B981).withAlpha(60); // Green
      borderColor = const Color(0xFF10B981).withAlpha(60);
    } else if (completionRate >= 0.5) {
      bgColor = const Color(0xFFF59E0B).withAlpha(60); // Yellow
      borderColor = const Color(0xFFF59E0B).withAlpha(60);
    } else if (completionRate > 0) {
      bgColor = const Color(0xFFF97316).withAlpha(60); // Orange
      borderColor = const Color(0xFFF97316).withAlpha(60);
    } else {
      bgColor = Colors.white.withAlpha(40); // None
      borderColor = Colors.white.withAlpha(60);
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Stack(
        children: [
          // Day number
          Center(
            child: Text(
              '$day',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Perfect completion indicator (small green dot)
          if (isPerfect)
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Builds the legend at the bottom of the calendar.
  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem('Perfect', const Color(0xFF10B981)),
        _buildLegendItem('Good', const Color(0xFFF59E0B)),
        _buildLegendItem('Partial', const Color(0xFFF97316)),
        _buildLegendItem('None', Colors.white.withAlpha(70)),
      ],
    );
  }

  /// Builds a single legend item with a colored box and label.
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withAlpha(200),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
