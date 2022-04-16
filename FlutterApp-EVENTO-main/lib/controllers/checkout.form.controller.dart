import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:evento_package/utilities/networking/output.handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/routes/route.names.dart';

class CheckOutFormController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();

  dynamic data;

  onLoad() {
    data = Get.arguments;
  }

  Future<void> addTicket(String paymentId, String status) async {
    try {
      CommonHelper().showLoading();
      final userId = await CommonHelper().getStorage(Constants().userId);
      final params = {
        'user': userId,
        'personalSkillId': data["perskillId"],
        'eventId': data["eventId"],
        'partnerId': data["parcomId"],
        'trans_Id': paymentId,
        'payment_status': status,
        'name': name.text,
        'email': emailId.text,
        'phone_no': phoneNumber.text,
        'address': address.text
      };
      OutputHandler result = await ApiMethods().postRequest('tickets', params);
      if (result.status == 200 && result.data != 0) {
        CommonHelper().hideLoading();
        Get.back();
        Get.back();
        Get.back();
        Get.toNamed(RouteNames().successFailBooking);
      }
    } catch (e) {
      CommonHelper().hideLoading();
      CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
  }

  Future<String> convertPrice(price) async {
    var dollarValue = "0.0";
    String countryCode =
        await CommonHelper().getStorage(Constants().countryCode);
    OutputHandler result =
        await ApiMethods().getRequest('convert/' + price.toString(), []);
    if (result.status == 200 && result.data != 0) {
      if (countryCode.toLowerCase() == "us") {
        dollarValue = result.data["usd"].toStringAsFixed(2).toString();
      } else if (countryCode.toLowerCase() == "fr" ||
          countryCode.toLowerCase() == "de") {
        dollarValue = result.data["eur"].toStringAsFixed(2).toString();
      } else if (countryCode.toLowerCase() == "hi") {
        dollarValue =
            double.parse(price.toString()).toStringAsFixed(2).toString();
      } else if (countryCode.toLowerCase() == "cn") {
        dollarValue = result.data["cny"].toStringAsFixed(2).toString();
      } else if (countryCode.toLowerCase() == "th") {
        dollarValue = result.data["thb"].toStringAsFixed(2).toString();
      } else {
        dollarValue =
            double.parse(price.toString()).toStringAsFixed(2).toString();
      }
    }
    return dollarValue;
  }
}
