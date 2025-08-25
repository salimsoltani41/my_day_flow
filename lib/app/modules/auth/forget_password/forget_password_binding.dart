import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/auth/forget_password/forget_password_controller.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgetPasswordController());
  }
}
