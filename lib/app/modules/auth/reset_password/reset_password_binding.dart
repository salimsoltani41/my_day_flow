import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/auth/reset_password/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResetPasswordController());
  }
}
