import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/networking/api.methods.dart';
import 'package:evento_package/utilities/networking/output.handler.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Dio dio = Dio();

class SearchController extends GetxController {
  final _commonHelper = CommonHelper();
  final _constants = Constants();

  List cardList = [];
  String searchText = '';
  var currentItemSelected = [];

  TextEditingController search = TextEditingController();

  //FILTER THINGS
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();

  List places = [
    {"places": "Home Wedding", "selected": false},
    {"places": "Store Opening", "selected": false},
    {"places": "Naming Ceremony", "selected": true},
    {"places": "Baby Shower", "selected": false},
    {"places": "Romantic Stay", "selected": false},
    {"places": "Romantic Dinner/Lunch", "selected": false},
    {"places": "Candle Night Dinner", "selected": false},
  ];

  String selectedItem = "Places";
  String selectedApi = "events_get";
  List drpdownItems = [
    {"title": "place", "value": "Places", "apiName": "events_get_list"},
    {
      "title": "partner",
      "value": "Partner Company",
      "apiName": "partnercompany_get_list"
    },
    {
      "title": "professional",
      "value": "Professional Skills",
      "apiName": "personalskill_get_list"
    },
  ];

  onSearch() {
    if (search.text != '' && search.text.length > 3) {
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

  fetch(bool isLoading) async {
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
}
