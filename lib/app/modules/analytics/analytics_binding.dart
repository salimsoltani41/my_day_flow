import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/analytics/analytics_controller.dart';

class AnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AnalyticsController());
  }
}
