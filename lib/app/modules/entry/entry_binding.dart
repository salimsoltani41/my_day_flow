import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/entry_controller.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/habits_controller.dart';
import 'package:my_day_flow/app/modules/entry/entry_controller/mood_controller.dart';

class EntryBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(EntryController());
    Get.put(HabitsController());
    Get.put(MoodController());
  }
}
