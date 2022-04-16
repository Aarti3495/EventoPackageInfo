import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:evento_package/utilities/networking/output.handler.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ResetController extends GetxController {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  void resetPassword() async {
    try {
      CommonHelper().showLoading();
      var userId = await CommonHelper().getStorage(Constants().userId);
      var params = {
        "userId": userId,
        "password": password.text,
        "password2": confirmPassword.text,
      };

      OutputHandler resData =
          await ApiMethods().putRequest('reset_password', params);
      debugPrint(resData.data.toString());
      if (resData.isSuccess == true && resData.status == 200) {
        CommonHelper().hideLoading();
        if (resData.data != null && resData.data != 0) {
          Get.toNamed(RouteNames().signIn);
          password.text = "";
          confirmPassword.text = "";
        } else {
          CommonHelper().alertMessage(resData.message.toString());
        }
      } else {
        CommonHelper().hideLoading();
        CommonHelper().errorMessage(Constants.someThingWentWrong);
      }
      update();
    } catch (e) {
      CommonHelper().hideLoading();
      CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
  }
}
