import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/auth/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
