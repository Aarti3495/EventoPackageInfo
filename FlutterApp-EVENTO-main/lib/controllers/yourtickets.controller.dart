import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:evento_package/models/ticket.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homeControllers/dashboard.controller.dart';

class YourTicketController extends GetxController {
  TextEditingController searchController = TextEditingController();
  dynamic user;
  List<TicketData> ticketList = [];
  final _constants = Constants();
  final _commonHelper = CommonHelper();

  getProfile() async {
    user = await CommonHelper().getStorage(Constants().userData);
    update();
  }

  Future<void> getTicket() async {
    ticketList.clear();
    update();
    CommonHelper().showLoading();
    String apiName = Constants().apiUrl + "tickets";
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        debugPrint(_constants.noInternetFound);
        await _commonHelper.alertMessage(_constants.noInternetFound);
        CommonHelper().hideLoading();
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          if (!_constants.noAuthRequest.contains(apiName)) {
            String authToken = await _commonHelper.getStorage(_constants.token);
            debugPrint("authToken : $authToken");
            dio.options.headers["Authorization"] = "Token $authToken";
          }
          var response = await dio.get(apiName);
          CommonHelper().hideLoading();
          Ticket ticket = Ticket.fromJson(response.data);
          if (ticket.data != null && ticket.data?.length != 0) {
            ticketList = ticket.data!;
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
}
