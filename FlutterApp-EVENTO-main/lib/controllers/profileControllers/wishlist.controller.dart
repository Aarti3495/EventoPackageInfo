import 'package:dio/dio.dart';
import 'package:evento_package/controllers/homeControllers/dashboard.controller.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:evento_package/utilities/networking/output.handler.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:get/get.dart';

import '../../utilities/constants.dart';

Dio dio = Dio();

class WishlistController extends GetxController {
  List wishList = [];

  removeFromWishlist(wishlistId) async {
    CommonHelper().showLoading();
    OutputHandler resData =
        await ApiMethods().deleteRequest('wishlist/$wishlistId');
    if (resData.isSuccess == true && resData.status == 200) {
      CommonHelper().hideLoading();
      DashboardController.dashboardFind.fetch(false);
      fetch();
      await CommonHelper().successMessage(resData.message);
    } else {
      CommonHelper().hideLoading();
      await CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
    update();
  }

  fetch() async {
    CommonHelper().showLoading();
    OutputHandler resData = await ApiMethods().getRequest('wishlist', []);
    if (resData.isSuccess == true && resData.status == 200) {
      wishList.clear();
      CommonHelper().hideLoading();
      if (resData.data != null) {
        wishList = resData.data;
      }
    } else {
      CommonHelper().hideLoading();
      await CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
    update();
  }

  Future<void> getEventDetails(wishData) async {
    var selectedApi = "";
    if (wishData["eventId"] != null) {
      selectedApi = "events_get_list/" + wishData["eventId"].toString();
    } else if (wishData["partnerId"] != null) {
      selectedApi =
          "partnercompany_get_list/" + wishData["partnerId"].toString();
    } else {
      selectedApi =
          "personalskill_get_list/" + wishData["personalId"].toString();
    }

    OutputHandler resData = await ApiMethods().getRequest(selectedApi, []);

    if (resData.isSuccess == true && resData.status == 200) {
      if (resData.data != null) {
        if (wishData["eventId"] != null) {
          Get.toNamed(RouteNames().eventDetail, arguments: resData.data[0]);
        } else if (wishData["partnerId"] != null) {
          Get.toNamed(RouteNames().partnerEventDetail,
              arguments: resData.data[0]);
        } else {
          Get.toNamed(RouteNames().personalSkillsEventDetailScreen,
              arguments: resData.data[0]);
        }
      }
    } else {
      CommonHelper().hideLoading();
      await CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
  }
}
