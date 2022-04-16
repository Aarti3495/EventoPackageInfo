import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FullVideoController extends GetxController {
  List data = [];
  int index = 0;

  onLoad() {
    data = Get.arguments[0];
    index = Get.arguments[1];
  }
}
