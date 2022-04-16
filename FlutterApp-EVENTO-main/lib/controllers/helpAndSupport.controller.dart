import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:evento_package/utilities/networking/output.handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/constants.dart';

class HelpAndSupportController extends GetxController {
  ScrollController scrollController = ScrollController();

  RxList<dynamic> messageList = <dynamic>[].obs;

  Future<void> sendMessage(String message) async {
    try {
      OutputHandler response =
          await ApiMethods().postRequest('chatbot', {"msg": message});
      if (response.status == 200 && response.data != 0) {
        try {
          OutputHandler response =
          await ApiMethods().getMessageFromChatBot('chatbot', []);
          if (response.status == 200 && response.data != 0) {
            messageList.clear();
            messageList.addAll(response.data);
            update();
          }
        } catch (e) {
          CommonHelper().errorMessage(Constants.someThingWentWrong);
        }
      }
    } catch (e) {
      CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
  }

  void getMessage() async {
    try {
      OutputHandler response =
          await ApiMethods().getMessageFromChatBot('chatbot', []);
      if (response.status == 200 && response.data != 0) {
        messageList.clear();
        messageList.addAll(response.data);
        update();
      }
    } catch (e) {
      CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
  }
}
