import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_controller.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_widget/monthly_calendar.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_widget/mood_chart.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_widget/report_header.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_widget/state_bar.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_widget/top_habit.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';

/// Main analytics screen displaying user insights.
///
/// This view aggregates multiple widgets:
/// - [ReportHeader] → Displays the user’s report summary (date, title, etc.).
/// - [StatsBar] → Shows key statistics (habits, moods, streaks, etc.).
/// - [MonthlyCalendar] → Calendar view with habit/mood tracking.
/// - [MoodChart] → Graphical chart of moods over time.
/// - [TopHabitsWidget] → Highlights the most performed habits.
///
/// The screen also uses a background gradient and a glass-like effect
/// helper function ([glassDecoration]) for styling consistency.
class AnalyticsView extends GetView<AnalyticsController> {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blueDeep,
        title: Text(AppStrings.analytics, style: AppTextStyles.headline()),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppGradient.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [
                // Report Summary Header
                ReportHeader(),
                SizedBox(height: 24),

                // Statistics Bar
                StatsBar(),
                SizedBox(height: 24),

                // Monthly Calendar
                MonthlyCalendar(),
                SizedBox(height: 24),

                // Mood Tracking Chart
                MoodChart(),
                SizedBox(height: 24),

                // Top Performing Habits
                TopHabitsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable glassmorphism decoration for widgets.
///
/// Adds a frosted glass-like effect with rounded corners, border, and shadow.
/// Can optionally take a [gradient] or [borderColor] for customization.
BoxDecoration glassDecoration({Gradient? gradient, Color? borderColor}) {
  return BoxDecoration(
    color: gradient == null ? Colors.white.withAlpha(30) : null,
    gradient: gradient,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: borderColor ?? Colors.white.withAlpha(40),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(50),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );
}
