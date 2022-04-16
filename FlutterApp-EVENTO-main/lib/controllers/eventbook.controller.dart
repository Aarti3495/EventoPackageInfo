import 'package:evento_package/models/ticket.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EventBookController extends GetxController {
  late TicketData data;

  onLoad() {
    data = Get.arguments;
  }
}
