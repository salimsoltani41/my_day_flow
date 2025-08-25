import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/data/models/report_model.dart';
import 'package:my_day_flow/core/widgets/glass_container.dart';
import 'dart:math' as math;

import 'package:my_day_flow/app/modules/analytics/analytics_controller.dart';

/// MoodChart widget displays a pie chart and a list summarizing
/// the user's moods for the week.
///
/// It includes:
/// - A chart visualization of moods.
/// - A center label showing the most frequent mood.
/// - A legend list with mood counts and colors.
class MoodChart extends GetView<AnalyticsController> {
  const MoodChart({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----- Header -----
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFEC4899).withAlpha(80),
                ),
                child: const Icon(
                  Icons.mood,
                  color: Color(0xFFF472B6),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Weekly Mood',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ----- Mood Chart -----
          _buildMoodChart(),
          const SizedBox(height: 24),

          // ----- Mood List -----
          _buildMoodList(),
        ],
      ),
    );
  }

  /// Builds the circular mood chart.
  Widget _buildMoodChart() {
    if (controller.weeklyMoodReport!.moodCounts.isEmpty) {
      return _buildEmptyChart();
    }

    return Center(
      child: SizedBox(
        width: 150,
        height: 150,
        child: Stack(
          children: [
            // Pie chart painter
            CustomPaint(
              size: const Size(150, 150),
              painter: MoodPieChartPainter(
                controller.weeklyMoodReport!.moodCounts,
              ),
            ),

            // Center info: most frequent mood
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Most Frequent',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      controller.weeklyMoodReport!.mostFrequentMood.mood,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds an empty placeholder when there is no mood data.
  Widget _buildEmptyChart() {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withAlpha(60),
          border: Border.all(color: Colors.white.withAlpha(40)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.mood_bad, color: Colors.white60, size: 32),
            SizedBox(height: 8),
            Text(
              'No mood data\nthis week',
              style: TextStyle(color: Colors.white60, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the list of moods with counts.
  Widget _buildMoodList() {
    if (controller.weeklyMoodReport!.moodCounts.isEmpty) {
      return const Center(
        child: Text(
          'Start tracking your mood to see insights!',
          style: TextStyle(color: Colors.white60, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: controller.weeklyMoodReport!.moodCounts.map((moodCount) {
        final gradient = moodCount.mood.color;
        final mainColor = _getMainColorFromGradient(gradient);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              // Mood color indicator
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),

              // Mood name
              Expanded(
                child: Text(
                  moodCount.mood.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),

              // Mood count
              Text(
                '${moodCount.count}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Extracts the primary color from a gradient.
  Color _getMainColorFromGradient(Gradient gradient) {
    try {
      if (gradient is LinearGradient || gradient is RadialGradient) {
        return gradient.colors.first;
      }
      return const Color(0xFF8B5CF6); // Default fallback color
    } catch (e) {
      return const Color(0xFF8B5CF6); // Fallback color in case of error
    }
  }
}

/// Custom painter that draws a pie chart for moods.
class MoodPieChartPainter extends CustomPainter {
  final List<MoodCount> moodCounts;

  MoodPieChartPainter(this.moodCounts);

  @override
  void paint(Canvas canvas, Size size) {
    if (moodCounts.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    // Total count for percentage calculation
    final total = moodCounts.fold<int>(
      0,
      (sum, moodCount) => sum + moodCount.count,
    );

    double startAngle = -math.pi / 2; // Start from top (12 o’clock)

    for (var moodCount in moodCounts) {
      final sweepAngle = (moodCount.count / total) * 2 * math.pi;

      final color = _getMainColorFromGradient(moodCount.mood.color);

      final paint = Paint()
        ..color = color.withAlpha(250)
        ..style = PaintingStyle.fill;

      // Draw arc for mood
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  /// Extracts the main color from gradient (used for pie slices).
  Color _getMainColorFromGradient(Gradient gradient) {
    try {
      if (gradient is LinearGradient || gradient is RadialGradient) {
        return gradient.colors.first;
      }
      return const Color(0xFF8B5CF6);
    } catch (e) {
      return const Color(0xFF8B5CF6);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
