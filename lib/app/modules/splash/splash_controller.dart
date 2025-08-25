import 'package:get/get.dart';
import 'package:my_day_flow/core/service/local_storage_service.dart';
import 'package:my_day_flow/app/routes/route_names.dart';

class SplashController extends GetxController {
  /// Initializes the splash logic by delaying for 2 seconds,
  /// then navigates to the appropriate screen based on login status.

  Future<void> _goToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));

    final isLogin = LocalStorageService.prefs.getBool('isLogin') ?? false;

    if (isLogin) {
      Get.offAllNamed(MyAppRouteNames.home); // user is logged in
    } else {
      Get.offAllNamed(MyAppRouteNames.login); // user is not logged in
    }
  }

  // CALL IT IN ONINIT TO MAKE SURE ACTION WILL BE TAKEN AT FIRST INITIALIZE
  @override
  void onInit() async {
    super.onInit();
    await _goToNextScreen();
  }
}
