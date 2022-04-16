import 'package:evento_package/models/ticket.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:get/get.dart';

class TalkWithOrganizerController extends GetxController {
  late TicketData ticketData;

  RxList<Map<String, dynamic>> messageList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    ticketData = Get.arguments;
  }


  void addMessageToMessageList(Map<String, dynamic> message) async {
    final userId = await CommonHelper().getStorage(Constants().userId);
    if (message["message"]["receiver"] == userId.toString() ||
        message["message"]["sender"] == userId) {
      messageList.add(message);
    }
  }
}
