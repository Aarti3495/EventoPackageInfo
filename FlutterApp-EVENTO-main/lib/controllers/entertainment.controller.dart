import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homeControllers/dashboard.controller.dart';

class EntertainmentController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List eventImageList = [];
  List eventVideoList = [];
  final _commonHelper = CommonHelper();
  final _constants = Constants();
  static EntertainmentController get entertainment => Get.find();

  dynamic user;
  dynamic data;
  int tabScroll = 0;

  getProfile() async {
    user = await CommonHelper().getStorage(Constants().userData);
    update();
  }

  Future<void> getEventImage() async {
    eventImageList.clear();
    update();
    CommonHelper().showLoading();
    String apiName = Constants().apiUrl + "galleryimage";
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
          debugPrint("$apiName URL: " + apiName);

          if (!_constants.noAuthRequest.contains(apiName)) {
            String authToken = await _commonHelper.getStorage(_constants.token);
            debugPrint("authToken : $authToken");
            dio.options.headers["Authorization"] = "Token $authToken";
          }

          var response = await dio.get(apiName);
          CommonHelper().hideLoading();
          if (response.data != null) {
            eventImageList = response.data["data"];
            debugPrint(eventImageList.toString());
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
        Get.offAndToNamed(RouteNames().signIn);
      } else {
        debugPrint("While Requesting => Exception -: ${e.toString()}");
        await _commonHelper.errorMessage(Constants.someThingWentWrong);
        update();
      }
    }
  }

  Future<void> getEventVideo() async {
    eventVideoList.clear();
    update();
    CommonHelper().showLoading();
    String apiName = Constants().apiUrl + "galleryvideo";
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
          debugPrint("$apiName URL: " + apiName);

          if (!_constants.noAuthRequest.contains(apiName)) {
            String authToken = await _commonHelper.getStorage(_constants.token);
            debugPrint("authToken : $authToken");
            dio.options.headers["Authorization"] = "Token $authToken";
          }

          var response = await dio.get(apiName);
          CommonHelper().hideLoading();
          if (response.data != null) {
            eventVideoList = response.data["data"];
            debugPrint(eventVideoList.toString());
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
        Get.offAndToNamed(RouteNames().signIn);
      } else {
        debugPrint("While Requesting => Exception -: ${e.toString()}");
        await _commonHelper.errorMessage(Constants.someThingWentWrong);
        update();
      }
    }
  }

  void load(_data, int _tabScroll) {
    data = _data;
    tabScroll = _tabScroll;
  }
}
