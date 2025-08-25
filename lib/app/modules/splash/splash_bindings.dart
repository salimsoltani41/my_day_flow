import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/splash/splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
