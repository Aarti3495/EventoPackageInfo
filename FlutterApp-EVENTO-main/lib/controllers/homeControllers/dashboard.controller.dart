import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:evento_package/controllers/loading.controller.dart';
import 'package:evento_package/models/ticket.dart';
import 'package:evento_package/models/user.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:evento_package/utilities/networking/output.handler.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Dio dio = Dio();

class DashboardController extends GetxController {
  static DashboardController get dashboardFind => Get.find();

  final _commonHelper = CommonHelper();
  final _constants = Constants();

  List cardList = [];
  String searchText = '';
  String selectPlace = '';
  var currentItemSelected = [];

  TextEditingController search = TextEditingController();

  //FILTER THINGS
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  TextEditingController location = TextEditingController();

  dynamic user;

  var priceRange = 0.0.obs;

  // add this
  getProfile() async {
    user = await CommonHelper().getStorage(Constants().userData);
    update();
  }

  List places = [
    {"places": "Home Wedding", "selected": false},
    {"places": "Store Opening", "selected": false},
    {"places": "Naming Ceremony", "selected": false},
    {"places": "Baby Shower", "selected": false},
    {"places": "Romantic Stay", "selected": false},
    {"places": "Romantic Dinner/Lunch", "selected": false},
    {"places": "Candle Night Dinner", "selected": false},
  ].obs;

  String selectedItem = "Places";
  String selectedApi = "events_get_list";
  List drpdownItems = [
    {
      "title": "Have You Places?",
      "svgImage": "assets/icons/0.1.1/park-bro1.svg",
      "value": "Places",
      "apiName": "events_get_list"
    },
    {
      "title": "Professional Skills",
      "svgImage": "assets/icons/0.1.1/progress-rafiki1.svg",
      "value": "Professional Skills",
      "apiName": "personalskill_get_list"
    },
    {
      "title": "Partner Company",
      "svgImage": "assets/icons/0.1.1/Partnership-rafiki1.svg",
      "value": "Partner Company",
      "apiName": "partnercompany_get_list"
    },
  ];

  onPlaceSelection(el) {
    for (int a = 0; a < places.length; a++) {
      if (places[a]['places'] == el['places']) {
        places[a]['selected'] = true;
      } else {
        places[a]['selected'] = false;
      }
    }
    update();
  }

  onSearch() {
    if (search.text != '' /*&& search.text.length > 3*/) {
      searchText = '?search=${search.text}';
      fetch(false);
    } else {
      searchText = '';
      fetch(false);
    }
  }

  onItemSelected(item) {
    selectedItem = item['value'];
    selectedApi = item['apiName'];
    search.text = "";
    searchText = '';
    Get.back();
    fetch(true);
  }

  toogleWishlist(item, type) async {
    try {
      if (item['whishlist_status']) {
        var wishId;
        if (type == "Professional Skills") {
          wishId = item['PersonalSkillWishlist'][0]['wishId'];
        } else if (type == "Partner Company") {
          wishId = item['PartnerCompWishlist'][0]['wishId'];
        } else {
          wishId = item['EventWishlist'][0]['wishId'];
        }
        String authToken = await _commonHelper.getStorage(_constants.token);
        dio.options.headers["Authorization"] = "Token $authToken";
        var result = await dio
            .delete(Constants().apiUrl + 'wishlist/' + wishId.toString());
        if (result.statusCode == 200 && result.data["data"] == "1") {
          fetch(true);
        }
      } else {
        var userId = await CommonHelper().getStorage(Constants().userId);
        var params = {"user": userId, "price_ev": item['price'] ?? "0"};
        if (type == "Professional Skills") {
          params["name_ev"] = item['name'];
          params["personalId"] = item['perskillId'];
          params["category"] = item['pro_category'];
          params["place_ev"] = item['com_address'];
          params["img"] = item['Photo'].length != 0
              ? item['Photo'][0]['photo_file']
              : item['Company_photo'].length
                  ? item['Company_photo'][0]['c_photo_file']
                  : "";
        } else if (type == "Partner Company") {
          params["name_ev"] = item['name'];
          params["partnerId"] = item['parcomId'];
          params["category"] = item['category'];
          params["place_ev"] = item['com_address'];
          params["img"] = item['photo'].length != 0
              ? item['photo'][0]['photo_file']
              : item['Company_photo'].length
                  ? item['Company_photo'][0]['c_photo_file']
                  : "";
        } else {
          params["eventId"] = item['eventId'];
          params["name_ev"] = item['display_name'];
          params["category"] = item['category'];
          params["place_ev"] = item['event']?[0]['place_name'];
          params["img"] = item['image'] != 0 ? item['image'][0]['image'] : "";
        }

        OutputHandler result =
            await ApiMethods().postRequest('wishlist', params);
        if (result.status == 200 && result.data != 0) {
          fetch(true);
        }
      }
    } catch (e) {
      CommonHelper().hideLoading();
      CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
  }

  filterClearOPtion() {
    for (int i = 0; i < places.length; i++) {
      places[i]["selected"] = false;
    }
    priceRange.value = 0.0;
    selectPlace = "";
    to.text = "";
    location.text = "";
    from.text = "";
    update();
  }

  fetch(bool isLoading) async {
    filterClearOPtion();
    if (isLoading) {
      CommonHelper().showLoading();
    }
    OutputHandler resData =
        await ApiMethods().getRequest(selectedApi + searchText, []);
    cardList.clear();
    if (resData.isSuccess == true && resData.status == 200) {
      CommonHelper().hideLoading();
      if (resData.data != null) {
        cardList = resData.data;
      }
    } else {
      CommonHelper().hideLoading();
      await CommonHelper().errorMessage(Constants.someThingWentWrong);
    }
    update();
  }

  Future<void> eventFilter() async {
    if ("events_get_list" == selectedApi) {
      var params = {
        "place_name": selectPlace,
        "min_personcapacity": from.text.toString(),
        "max_personcapacity": to.text.toString(),
        "address": location.text.toString(),
        "price": (priceRange.value!=null)?priceRange.value.toInt():0,
      };
      CommonHelper().showLoading();
      String apiName = Constants().apiUrl + "events_get_list";
      try {
        var connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          debugPrint(_constants.noInternetFound);
          await _commonHelper.alertMessage(_constants.noInternetFound);
          CommonHelper().hideLoading();
        } else {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            debugPrint("Internet Connected!");
            debugPrint("$apiName URL: " + apiName + searchText);

            if (!_constants.noAuthRequest.contains(apiName)) {
              String authToken =
                  await _commonHelper.getStorage(_constants.token);
              debugPrint("authToken : $authToken");
              dio.options.headers["Authorization"] = "Token $authToken";
            }
            var response = await dio.get(apiName, queryParameters: params);
            cardList.clear();
            if (response.statusCode == 200) {
              CommonHelper().hideLoading();
              if (response.data != null && response.data["data"] != null) {
                cardList = response.data["data"];
              }
              filterClearOPtion();
              Get.back();
            }
          } else {
            CommonHelper().hideLoading();
            await _commonHelper.alertMessage(_constants.noInternetFound);
          }
        }
        update();
      } on SocketException catch (e) {
        CommonHelper().hideLoading();
        debugPrint("While Requesting => SocketException -: ${e.toString()}");
        await _commonHelper.alertMessage(_constants.noInternetFound);
        update();
      } on DioError catch (e) {
        CommonHelper().hideLoading();
        if (e.response != null && e.response!.statusCode == 401) {
          await _commonHelper.removeByKeyStorage(Constants().userData);
          await _commonHelper.removeByKeyStorage(Constants().userId);
          await _commonHelper.removeByKeyStorage(Constants().token);
          CommonHelper().hideLoading();
          Get.offAndToNamed(RouteNames().signIn);
          _commonHelper.errorMessage("loginBTN".tr,);
        } else {
          debugPrint("While Requesting => Exception -: ${e.toString()}");
          await _commonHelper.errorMessage(Constants.someThingWentWrong);
          update();
        }
      }
    } else {
      Get.back();
    }
  }

  void selectedPlace({required bool selected, required String place}) {
    for (var i = 0; i < places.length; i++) {
      if (places[i]["places"] == place) {
        places[i]["selected"] = true;
        selectPlace = place;
      } else {
        places[i]["selected"] = false;
      }
    }
    update();
  }

  void changePriceRange(double value) {
    priceRange.value = value;
    update();
  }

  Future<String> convertPrice(price) async {
    var dollarValue = "0.0";
    String countryCode =
        await CommonHelper().getStorage(Constants().countryCode);
    OutputHandler result =
        await ApiMethods().getRequest('convert/' + price.toString(), []);
    if (result.status == 200 && result.data != 0) {
      if (countryCode.toLowerCase() == "us") {
        dollarValue =
            result.data["usd"].toStringAsFixed(2).toString() + " " + "USD";
      } else if (countryCode.toLowerCase() == "fr" ||
          countryCode.toLowerCase() == "de") {
        dollarValue =
            result.data["eur"].toStringAsFixed(2).toString() + " " + "EUR";
      } else if (countryCode.toLowerCase() == "hi") {
        dollarValue =
            double.parse(price.toString()).toStringAsFixed(2).toString() +
                " " +
                "INR";
      } else if (countryCode.toLowerCase() == "cn") {
        dollarValue =
            result.data["cny"].toStringAsFixed(2).toString() + " " + "CNY";
      } else if (countryCode.toLowerCase() == "th") {
        dollarValue =
            result.data["thb"].toStringAsFixed(2).toString() + " " + "THB";
      } else {
        dollarValue =
            double.parse(price.toString()).toStringAsFixed(2).toString() +
                " " +
                "INR";
      }
    }
    return dollarValue;
  }
}
