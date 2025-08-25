import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:my_day_flow/core/constants/colors.dart';

/// A sophisticated habit card widget with glassmorphism design and swipe actions
///
/// This widget displays habit information in a modern glassmorphism style card
/// with backdrop blur effects and gradient overlays. It supports swipe gestures
/// for completing and deleting habits.
///
/// Key Features:
/// - Glassmorphism visual design with blur effects
/// - Swipe-to-complete and swipe-to-delete functionality
/// - Dynamic icon selection based on habit name
/// - Gradient color indicator for habit categorization
/// - Responsive layout with proper text overflow handling
/// - Visual state indication for completed habits
class GlassmorphismHabitCard extends StatelessWidget {
  /// The display name of the habit
  final String habitName;

  /// Optional time when the habit should be performed (e.g., "9:00 AM")
  final String? time;

  /// Optional frequency of the habit (e.g., "Daily", "Weekly")
  final String? frequency;

  /// Text to display on the complete action button
  final String completeText;

  /// Gradient colors used for the habit's color indicator
  final LinearGradient habitColor;

  /// Callback function triggered when user swipes to delete
  final void Function(BuildContext)? onDelete;

  /// Callback function triggered when user swipes to complete/uncomplete
  final void Function(BuildContext)? onComplete;

  /// Whether this habit is currently marked as completed
  final bool isCompleted;

  const GlassmorphismHabitCard({
    super.key,
    required this.habitName,
    this.time,
    this.frequency,
    required this.habitColor,
    this.onDelete,
    this.onComplete,
    this.isCompleted = false,
    required this.completeText,
  });

  /// Determines the appropriate icon based on habit name content
  ///
  /// Uses keyword matching to assign contextual icons that help users
  /// quickly identify different types of habits at a glance.
  ///
  /// Returns [Icons.task_alt] as the default icon for unmatched habits.
  IconData _getHabitIcon() {
    final habitLower = habitName.toLowerCase();

    // Water-related habits
    if (habitLower.contains('water') || habitLower.contains('drink')) {
      return Icons.water_drop;
    }
    // Exercise and fitness habits
    else if (habitLower.contains('exercise') ||
        habitLower.contains('workout') ||
        habitLower.contains('run')) {
      return Icons.fitness_center;
    }
    // Reading habits
    else if (habitLower.contains('read') || habitLower.contains('book')) {
      return Icons.menu_book;
    }
    // Meditation and mindfulness habits
    else if (habitLower.contains('meditat') || habitLower.contains('mindful')) {
      return Icons.self_improvement;
    }
    // Sleep-related habits
    else if (habitLower.contains('sleep')) {
      return Icons.bedtime;
    }
    // Walking habits
    else if (habitLower.contains('walk')) {
      return Icons.directions_walk;
    }
    // Writing and journaling habits
    else if (habitLower.contains('write') || habitLower.contains('journal')) {
      return Icons.edit;
    }
    // Default icon for unmatched habits
    else {
      return Icons.task_alt;
    }
  }

  /// Builds the glassmorphism effect container with proper layering
  ///
  /// Creates a multi-layered visual effect including:
  /// - Gradient background with transparency
  /// - Border with semi-transparent white
  /// - Drop shadow for depth
  /// - Backdrop blur filter for glassmorphism
  Widget _buildGlassmorphismContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // Outer gradient for the glassmorphism base
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withAlpha(40), // Semi-transparent white top
            Colors.white.withAlpha(25), // More transparent bottom
          ],
        ),
        // Subtle border for glass edge definition
        border: Border.all(color: Colors.white.withAlpha(60), width: 1),
        // Soft shadow for depth perception
        boxShadow: [
          BoxShadow(
            color: Colors.white.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          // Apply blur effect for glassmorphism
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // Inner gradient for additional depth
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white.withAlpha(20), Colors.white.withAlpha(5)],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  /// Builds the habit color indicator with icon
  ///
  /// Creates a circular container with the habit's gradient color
  /// and displays an appropriate icon based on the habit type.
  Widget _buildHabitIndicator() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: habitColor,
        // Shadow for visual depth
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(100),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(_getHabitIcon(), color: Colors.white, size: 24),
    );
  }

  /// Builds the habit information section with name, time, and frequency
  ///
  /// Handles text styling based on completion status and provides
  /// proper overflow handling for long habit names.
  Widget _buildHabitInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Habit name with completion state styling
          Text(
            habitName,
            style: _getHabitNameTextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Time and frequency information (if available)
          if (time != null || frequency != null) _buildTimeFrequencyRow(),
        ],
      ),
    );
  }

  /// Returns the appropriate text style based on completion status
  ///
  /// Applies strikethrough decoration for completed habits while
  /// maintaining readability and visual hierarchy.
  TextStyle _getHabitNameTextStyle() {
    const baseStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );

    if (isCompleted) {
      return baseStyle.copyWith(
        decorationColor: AppColors.white,
        decorationThickness: 2,
        decorationStyle: TextDecorationStyle.solid,
        decoration: TextDecoration.lineThrough,
      );
    }

    return baseStyle;
  }

  /// Builds the row containing time and frequency information
  ///
  /// Creates a horizontal layout with icons and text for both
  /// time and frequency when available.
  Widget _buildTimeFrequencyRow() {
    return Row(
      children: [
        // Time information
        if (time != null) ...[
          const Icon(Icons.access_time, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            time!,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],

        // Spacing between time and frequency
        if (time != null && frequency != null) const SizedBox(width: 16),

        // Frequency information
        if (frequency != null) ...[
          const Icon(Icons.repeat, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            frequency!,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ],
    );
  }

  /// Builds the main content row with habit indicator and information
  Widget _buildMainContent() {
    return Row(
      children: [
        _buildHabitIndicator(),
        const SizedBox(width: 16),
        _buildHabitInfo(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Left swipe action for completing/uncompleting habits
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            label: completeText,
            backgroundColor: AppColors.transparent,
            onPressed: onComplete,
            icon: isCompleted ? Icons.radio_button_unchecked : Icons.check,
          ),
        ],
      ),

      // Right swipe action for deleting habits
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            backgroundColor: AppColors.transparent,
            onPressed: onDelete,
            icon: Icons.delete,
          ),
        ],
      ),

      // Main card content with glassmorphism effect
      child: _buildGlassmorphismContainer(child: _buildMainContent()),
    );
  }
}
