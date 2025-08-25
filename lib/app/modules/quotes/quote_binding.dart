import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/quotes/quote_controller.dart';

class QuoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(QuoteController());
  }
}
