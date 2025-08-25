import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/home/home_controller.dart';
import 'package:my_day_flow/app/modules/quotes/quote_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(QuoteController());
  }
}
