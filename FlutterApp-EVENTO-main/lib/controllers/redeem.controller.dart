import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:evento_package/utilities/networking/output.handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RedeemController extends GetxController {
  List redeemList = [];
  var dollar_value = 0.0;

  Future<void> fetchTransaction() async {
    CommonHelper().showLoading();
    OutputHandler resData = await ApiMethods().getRequest("transaction", []);
    redeemList.clear();
    if (resData.isSuccess == true && resData.status == 200) {
      CommonHelper().hideLoading();
      if (resData.data != null) {
        redeemList = resData.data;
      }
    } else {
      CommonHelper().hideLoading();
      await CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
    update();
  }

  Future<void> addredeem(String upiId, redeem) async {
    var userId = await CommonHelper().getStorage(Constants().userId);
    var params = {
      "user": userId,
      "Amount": redeem,
      "upi_id": upiId,
      "price": redeem * 10,
    };
    OutputHandler result = await ApiMethods().postRequest('redeem', params);
    if (result.status == 200 && result.data != 0) {
      fetchTransaction();
      Get.back();
    }
    else{
      print(result.data);
    }
  }

  convertPrice(price) async {
    OutputHandler result =
        await ApiMethods().getRequest('convert/' + price.toString(), []);
    if (result.status == 200 && result.data != 0) {
      dollar_value = result.data["usd"];
      print("Dollar______" + dollar_value.toString());
    }
  }
}
