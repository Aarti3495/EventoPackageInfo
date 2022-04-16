import 'package:evento_package/models/ticket.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CheckoutDetailController extends GetxController {
  dynamic data;

  onLoad() {
    data = Get.arguments;
  }
}
