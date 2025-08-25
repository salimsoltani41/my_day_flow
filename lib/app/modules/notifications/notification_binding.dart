import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/notifications/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}
