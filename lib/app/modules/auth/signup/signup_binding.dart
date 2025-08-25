import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/auth/signup/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupController());
  }
}
