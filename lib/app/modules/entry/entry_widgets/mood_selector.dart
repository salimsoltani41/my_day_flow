import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/mood_controller.dart';
import 'package:my_day_flow/app/modules/entry/entry_models/mood_list_model.dart';
import 'package:my_day_flow/app/modules/entry/entry_widgets/mood_card.dart';

/// A widget that displays a grid of moods for the user to select.
///
/// This widget uses GetX's [GetView] to directly access the [MoodController].
/// It builds a grid of [MoodCard]s based on the `moods` list.
class MoodSelector extends GetView<MoodController> {
  const MoodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // Prevents GridView from shrinking and lets it take available space
      shrinkWrap: false,

      // Number of items in the grid = number of moods
      itemCount: moods.length,

      // Grid layout configuration
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        mainAxisExtent: 100, // Fixed height of each item
        crossAxisSpacing: 40, // Horizontal spacing between items
        mainAxisSpacing: 15, // Vertical spacing between items
      ),

      // Builds each grid item (a MoodCard)
      itemBuilder: (context, index) {
        return MoodCard(index: index);
      },
    );
  }
}
