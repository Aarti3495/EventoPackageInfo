import 'package:dio/dio.dart';
import 'package:evento_package/controllers/homeControllers/dashboard.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:evento_package/utilities/networking/output.handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Dio dio = Dio();

class EventDetailController extends GetxController {
  dynamic data;
  final _commonHelper = CommonHelper();
  final _constants = Constants();
  double userRating = 1;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController review = TextEditingController();

  var ratingValue = 0.0;

  onLoad() {
    data = Get.arguments;
  }

  addRating(int eventId, int i) async {
    CommonHelper().showLoading();
    var userId = await CommonHelper().getStorage(Constants().userId);
    var preData = {
      i == 1
          ? 'eventId'
          : i == 2
              ? 'personalId'
              : 'partnerId': eventId,
      'User': userId,
      'stars': userRating,
      'name': name.text,
      'email': email.text,
      'review': review.text
    };
    OutputHandler resData = await ApiMethods().postRequest('rateus', preData);
    if (resData.isSuccess == true && resData.status == 200) {
      CommonHelper().hideLoading();
      name.text = "";
      email.text = "";
      review.text = "";
      userRating = 1;
      await CommonHelper().successMessage("Review Submitted!");
      DashboardController.dashboardFind.fetch(false);
      if (i == 1) {
        data['EventRating'].add(resData.data);
        prepareRating(data['EventRating']);
      } else if (i == 2) {
        data['PersonalSkillRating'].add(resData.data);
        prepareRating(data['PersonalSkillRating']);
      } else {
        data['PartnerCompRating'].add(resData.data);
        prepareRating(data['PartnerCompRating']);
      }
      update();
    } else {
      CommonHelper().hideLoading();
      await CommonHelper().alertMessage(resData.message);
    }
  }

  toogleWishlist(type) async {
    try {
      if (data['whishlist_status']) {
        var wishId;
        if (type == "Professional Skills") {
          wishId = data['PersonalSkillWishlist'][0]['wishId'];
        } else if (type == "Partner Company") {
          wishId = data['PartnerCompWishlist'][0]['wishId'];
        } else {
          wishId = data['EventWishlist'][0]['wishId'];
        }
        String authToken = await _commonHelper.getStorage(_constants.token);
        dio.options.headers["Authorization"] = "Token $authToken";
        var result = await dio
            .delete(Constants().apiUrl + 'wishlist/' + wishId.toString());
        if (result.statusCode == 200 && result.data["data"] == "1") {
          DashboardController.dashboardFind.fetch(false);
          data['whishlist_status'] = false;
          update();
        }
      } else {
        var userId = await CommonHelper().getStorage(Constants().userId);
        var params = {"user": userId, "price_ev": data['price'] ?? "0"};
        if (type == "Professional Skills") {
          params["name_ev"] = data['name'];
          params["personalId"] = data['perskillId'];
          params["category"] = data['pro_category'];
          params["place_ev"] = data['com_address'];
          params["img"] = data['Photo'].length != 0
              ? data['Photo'][0]['photo_file']
              : data['Company_photo'].length
                  ? data['Company_photo'][0]['c_photo_file']
                  : "";
        } else if (type == "Partner Company") {
          params["name_ev"] = data['name'];
          params["partnerId"] = data['parcomId'];
          params["category"] = data['category'];
          params["place_ev"] = data['com_address'];
          params["img"] = data['photo'].length != 0
              ? data['photo'][0]['photo_file']
              : data['Company_photo'].length
                  ? data['Company_photo'][0]['c_photo_file']
                  : "";
        } else {
          params["eventId"] = data['eventId'];
          params["name_ev"] = data['display_name'];
          params["category"] = data['category'];
          params["place_ev"] = data['event']?[0]['place_name'];
          params["img"] = data['image'] != 0 ? data['image'][0]['image'] : "";
        }

        OutputHandler result =
            await ApiMethods().postRequest('wishlist', params);
        if (result.status == 200 && result.data != 0) {
          DashboardController.dashboardFind.fetch(false);
          if (type == "Professional Skills") {
            data['PersonalSkillWishlist'].add(result.data);
          } else if (type == "Partner Company") {
            data['PartnerCompWishlist'].add(result.data);
          } else {
            data['EventWishlist'].add(result.data);
          }

          data['whishlist_status'] = true;
          update();
        }
      }
    } catch (e) {
      CommonHelper().hideLoading();
      CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
  }

  prepareRating(data) {
    ratingValue = CommonHelper().prepareRating(data);
    update();
  }
}
