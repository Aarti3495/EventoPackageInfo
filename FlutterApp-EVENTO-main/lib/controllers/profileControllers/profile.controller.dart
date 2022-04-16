import 'package:evento_package/models/user.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:evento_package/utilities/networking/output.handler.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _commonHelper = CommonHelper();
  final _constants = Constants();
  TextEditingController emailIdORNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  dynamic user;

  static ProfileController get profileController => Get.find();

  getProfile() async {
    user = await CommonHelper().getStorage(Constants().userData);
    update();
    try {
      OutputHandler userData = await ApiMethods().getRequest("user", []);
      print(userData.data.toString());
      if (userData.isSuccess == true && userData.status == 200) {
        if (userData.data != null && userData.data != "") {
          var userdata = User.fromJson(userData.data[0]);
          CommonHelper().writeStorage(Constants().userData, userdata);
          user = await CommonHelper().getStorage(Constants().userData);
          update();
        } else {
          CommonHelper().alertMessage(userData.message.toString());
        }
      } else {
        CommonHelper().errorMessage(userData.message.toString());
      }
      update();
    } catch (e) {
      CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
    update();
  }

  logout() async {
    CommonHelper().showLoading();
    final userId = await _commonHelper.getStorage(_constants.userId);
    OutputHandler outputHandler =
        await ApiMethods().deleteRequest("${Constants.appToken}/$userId");
    print("Logout appToken ====== ${outputHandler.message}");
    OutputHandler resData = await ApiMethods().getRequest('logout', []);
    if (resData.isSuccess == true && resData.status == 200) {
      CommonHelper().hideLoading();
      if (resData.data.toString() == "1") {
        await _commonHelper.removeByKeyStorage(_constants.userData);
        await _commonHelper.removeByKeyStorage(_constants.userId);
        await _commonHelper.removeByKeyStorage(_constants.token);
        Get.offNamed(RouteNames().signIn);
      }
    } else {
      CommonHelper().hideLoading();
      await CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
    update();
  }
}
