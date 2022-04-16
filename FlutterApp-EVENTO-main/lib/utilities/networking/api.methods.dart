import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getRout;

import '../../controllers/loading.controller.dart';
import '../routes/route.names.dart';
import 'output.handler.dart';

Dio dio = Dio();
Constants _constants = Constants();
CommonHelper _commonHelper = CommonHelper();

class ApiMethods {
  ApiMethods() {
    dio.options
      ..baseUrl = _constants.apiUrl
      ..headers = {
        'Accept': 'application/json',
      };
  }

  Future<OutputHandler> getRequest(String apiName, List params) async {
    OutputHandler outputData = OutputHandler(
        message: _constants.noInternetFound,
        isSuccess: false,
        data: null,
        status: 0);
    try {
      debugPrint("Starting Request");
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        debugPrint(_constants.noInternetFound);
        _commonHelper.alertMessage(_constants.noInternetFound);
        return outputData;
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          debugPrint("Internet Connected!");
          String url = await createGetURL(apiName, params);
          debugPrint("$apiName URL: " + url);

          String authToken = await _commonHelper.getStorage(_constants.token);
          debugPrint("authToken : $authToken");
          dio.options.headers["Authorization"] = "Token $authToken";

          Response response = await dio.get(url);
          outputData = await responseHandler(response);

          return outputData;
        } else {
          return outputData;
        }
      }
    } on SocketException catch (e) {
      debugPrint("While Requesting => SocketException -: ${e.toString()}");
      _commonHelper.alertMessage(_constants.noInternetFound);
      return outputData;
    } on DioError catch (e) {
      _commonHelper.hideLoading();
      debugPrint("While Requesting => Exception -: ${e.toString()}");
      if (e.response != null && e.response!.statusCode == 401) {
        await _commonHelper.removeByKeyStorage(Constants().userData);
        await _commonHelper.removeByKeyStorage(Constants().userId);
        await _commonHelper.removeByKeyStorage(Constants().token);
        getRout.Get.offAndToNamed(RouteNames().signIn);
        //_commonHelper.errorMessage("loginBTN".tr,);
      }
      if (e.response != null &&
          _commonHelper.isNumericCheck(e.response!.statusCode.toString())) {
        outputData.data = e.response!.data['data'];
        outputData.message = e.response!.data['message'];
        outputData.isSuccess = e.response!.data['isSuccess'];
        outputData.status = int.parse(e.response!.statusCode.toString());
      } else {
        outputData.data = 0;
        outputData.message = e.error.toString();
        outputData.isSuccess = false;
        outputData.status = 500;
      }
      return outputData;
    }
  }

  Future<OutputHandler> postRequest(String apiName, body) async {
    OutputHandler outputData = OutputHandler(
        message: _constants.noInternetFound,
        isSuccess: false,
        data: null,
        status: 0);
    try {
      debugPrint("Starting Request");
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        debugPrint(_constants.noInternetFound);
        _commonHelper.alertMessage(_constants.noInternetFound);
        return outputData;
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          debugPrint("Internet Connected!");
          debugPrint("$apiName URL: " + apiName);

          if (!Constants().noAuthRequest.contains(apiName)) {
            String authToken = await _commonHelper.getStorage(_constants.token);
            debugPrint("authToken : $authToken");
            if (authToken != "") {
              dio.options.headers["Authorization"] = "Token $authToken";
            }
          }

          Response response =
              await dio.post(Constants().apiUrl + apiName, data: body);
          outputData = await responseHandler(response);
          return outputData;
        } else {
          return outputData;
        }
      }
    } on SocketException catch (e) {
      debugPrint("While Requesting => SocketException -: ${e.toString()}");
      _commonHelper.alertMessage(_constants.noInternetFound);
      CommonHelper().hideLoading();
      return outputData;
    } on DioError catch (e) {
      CommonHelper().hideLoading();
      debugPrint("While Requesting => Exception -: ${e.error.toString()}");
      if (e.response != null && e.response!.statusCode == 401) {
        await _commonHelper.removeByKeyStorage(Constants().userData);
        await _commonHelper.removeByKeyStorage(Constants().userId);
        await _commonHelper.removeByKeyStorage(Constants().token);
        _commonHelper.hideLoading();
        getRout.Get.offAndToNamed(RouteNames().signIn);
        //_commonHelper.errorMessage("loginBTN".tr,);
      }
      if (e.response != null &&
          _commonHelper.isNumericCheck(e.response!.statusCode.toString())) {
        outputData.data = e.response!.data['data'];
        outputData.message = e.response!.data['message'];
        outputData.isSuccess = e.response!.data['isSuccess'];
        outputData.status = int.parse(e.response!.statusCode.toString());
      } else {
        outputData.data = 0;
        outputData.message = e.error.toString();
        outputData.isSuccess = false;
        outputData.status = 500;
      }
      return outputData;
    }
  }

  Future<OutputHandler> getMessageFromChatBot(
      String apiName, List params) async {
    OutputHandler outputData = OutputHandler(
        message: _constants.noInternetFound,
        isSuccess: false,
        data: null,
        status: 0);
    try {
      debugPrint("Starting Request");
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        debugPrint(_constants.noInternetFound);
        _commonHelper.alertMessage(_constants.noInternetFound);
        return outputData;
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          debugPrint("Internet Connected!");
          String url = await createGetURL(apiName, params);
          // debugPrint("$apiName URL: " + "${Constants.chatBoatUrl}$apiName");
          debugPrint("$apiName URL: " + url);
          String authToken = await _commonHelper.getStorage(_constants.token);
          debugPrint("authToken : $authToken");
          dio.options.headers["Authorization"] = "Token $authToken";

          Response response = await dio.get(url);
          outputData = await responseHandler(response);

          return outputData;
        } else {
          return outputData;
        }
      }
    } on SocketException catch (e) {
      debugPrint("While Requesting => SocketException -: ${e.toString()}");
      _commonHelper.alertMessage(_constants.noInternetFound);
      return outputData;
    } on DioError catch (e) {
      debugPrint("While Requesting => Exception -: ${e.toString()}");
      if (e.response != null && e.response!.statusCode == 401) {
        await _commonHelper.removeByKeyStorage(Constants().userData);
        await _commonHelper.removeByKeyStorage(Constants().userId);
        await _commonHelper.removeByKeyStorage(Constants().token);
        _commonHelper.hideLoading();
        getRout.Get.offAndToNamed(RouteNames().signIn);
        //_commonHelper.errorMessage("loginBTN".tr,);
      }
      if (e.response != null &&
          _commonHelper.isNumericCheck(e.response!.statusCode.toString())) {
        outputData.data = e.response!.data['data'];
        outputData.message = e.response!.data['message'];
        outputData.isSuccess = e.response!.data['isSuccess'];
        outputData.status = int.parse(e.response!.statusCode.toString());
      } else {
        outputData.data = 0;
        outputData.message = e.error.toString();
        outputData.isSuccess = false;
        outputData.status = 500;
      }
      return outputData;
    }
  }

  Future<OutputHandler> postMessage(
      String apiName, Map<String, dynamic> body) async {
    OutputHandler outputData = OutputHandler(
        message: _constants.noInternetFound,
        isSuccess: false,
        data: null,
        status: 0);
    try {
      debugPrint("Starting Request");
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        debugPrint(_constants.noInternetFound);
        _commonHelper.alertMessage(_constants.noInternetFound);
        return outputData;
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          debugPrint("Internet Connected!");

          if (!Constants().noAuthRequest.contains(apiName)) {
            String authToken = await _commonHelper.getStorage(_constants.token);
            debugPrint("authToken : $authToken");
            if (authToken != "") {
              dio.options.headers["Authorization"] = "Token $authToken";
            }
          }
          Response response =
              await dio.post(Constants.chatBoatUrl + apiName, data: body);
          outputData = await responseHandler(response);
          return outputData;
        } else {
          return outputData;
        }
      }
    } on SocketException catch (e) {
      debugPrint("While Requesting => SocketException -: ${e.toString()}");
      _commonHelper.alertMessage(_constants.noInternetFound);
      CommonHelper().hideLoading();
      return outputData;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        await _commonHelper.removeByKeyStorage(Constants().userData);
        await _commonHelper.removeByKeyStorage(Constants().userId);
        await _commonHelper.removeByKeyStorage(Constants().token);
        _commonHelper.hideLoading();
        getRout.Get.offAndToNamed(RouteNames().signIn);
        //_commonHelper.errorMessage("loginBTN".tr,);
      }
      CommonHelper().hideLoading();
      debugPrint("While Requesting => Exception -: ${e.error.toString()}");
      if (e.response != null &&
          _commonHelper.isNumericCheck(e.response!.statusCode.toString())) {
        outputData.data = e.response!.data['data'];
        outputData.message = e.response!.data['message'];
        outputData.isSuccess = e.response!.data['isSuccess'];
        outputData.status = int.parse(e.response!.statusCode.toString());
      } else {
        outputData.data = 0;
        outputData.message = e.error.toString();
        outputData.isSuccess = false;
        outputData.status = 500;
      }
      return outputData;
    }
  }

  Future<OutputHandler> deleteRequest(String apiName) async {
    OutputHandler outputData = OutputHandler(
        message: _constants.noInternetFound,
        isSuccess: false,
        data: null,
        status: 0);
    try {
      debugPrint("Starting Request");
      var Url = Constants().apiUrl + apiName;
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        debugPrint(_constants.noInternetFound);
        _commonHelper.alertMessage(_constants.noInternetFound);
        return outputData;
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          debugPrint("Internet Connected!");
          debugPrint("$apiName URL: " + Url);

          if (!Constants().noAuthRequest.contains(Url)) {
            String authToken = await _commonHelper.getStorage(_constants.token);
            debugPrint("authToken : $authToken");
            dio.options.headers["Authorization"] = "Token $authToken";
          }
          Response response = await dio.delete(Url);
          outputData = await responseHandler(response);
          return outputData;
        } else {
          return outputData;
        }
      }
    } on SocketException catch (e) {

      debugPrint("While Requesting => SocketException -: ${e.toString()}");
      _commonHelper.alertMessage(_constants.noInternetFound);
      return outputData;
    } on DioError catch (e) {
      debugPrint("While Requesting => Exception -: ${e.error.toString()}");
      if (e.response != null && e.response!.statusCode == 401) {
        await _commonHelper.removeByKeyStorage(Constants().userData);
        await _commonHelper.removeByKeyStorage(Constants().userId);
        await _commonHelper.removeByKeyStorage(Constants().token);
        _commonHelper.hideLoading();
        getRout.Get.offAndToNamed(RouteNames().signIn);
        //_commonHelper.errorMessage("loginBTN".tr,);
      }
      if (e.response != null &&
          _commonHelper.isNumericCheck(e.response!.statusCode.toString())) {
        outputData.data = e.response!.data['data'];
        outputData.message = e.response!.data['message'];
        outputData.isSuccess = e.response!.data['isSuccess'];
        outputData.status = int.parse(e.response!.statusCode.toString());
      } else {
        outputData.data = 0;
        outputData.message = e.error.toString();
        outputData.isSuccess = false;
        outputData.status = 500;
      }
      return outputData;
    }
  }

  Future<OutputHandler> putRequest(String apiName, body) async {
    OutputHandler outputData = OutputHandler(
        message: _constants.noInternetFound,
        isSuccess: false,
        data: null,
        status: 0);
    try {
      debugPrint("Starting Request");
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        debugPrint(_constants.noInternetFound);
        _commonHelper.alertMessage(_constants.noInternetFound);
        return outputData;
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          debugPrint("Internet Connected!");
          debugPrint("$apiName URL: " + apiName);

          if (!Constants().noAuthRequest.contains(apiName)) {
            String authToken = await _commonHelper.getStorage(_constants.token);
            debugPrint("authToken : $authToken");
            if (authToken != "") {
              dio.options.headers["Authorization"] = "Token $authToken";
            }
          }

          Response response = await dio.put(apiName, data: body);
          outputData = await responseHandler(response);
          return outputData;
        } else {
          return outputData;
        }
      }
    } on SocketException catch (e) {
      debugPrint("While Requesting => SocketException -: ${e.toString()}");
      _commonHelper.alertMessage(_constants.noInternetFound);
      return outputData;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        await _commonHelper.removeByKeyStorage(Constants().userData);
        await _commonHelper.removeByKeyStorage(Constants().userId);
        await _commonHelper.removeByKeyStorage(Constants().token);
        _commonHelper.hideLoading();
        getRout.Get.offAndToNamed(RouteNames().signIn);
        //_commonHelper.errorMessage("loginBTN".tr,);
      }
      debugPrint("While Requesting => Exception -: ${e.error.toString()}");
      if (e.response != null &&
          _commonHelper.isNumericCheck(e.response!.statusCode.toString())) {
        outputData.data = e.response!.data['data'];
        outputData.message = e.response!.data['message'];
        outputData.isSuccess = e.response!.data['isSuccess'];
        outputData.status = int.parse(e.response!.statusCode.toString());
      } else {
        outputData.data = 0;
        outputData.message = e.error.toString();
        outputData.isSuccess = false;
        outputData.status = 500;
      }
      return outputData;
    }
  }

  static Future<String> createGetURL(String apiName, List params) async {
    String url = "";
    if (params.isNotEmpty) {
      url = apiName + "?";
      for (int i = 0; i < params.length; i++) {
        url = url + '${params[i]["key"]}=${params[i]["value"]}';
        if (i + 1 != params.length) url = url + "&";
      }
    } else {
      url = Constants().apiUrl + apiName;
    }
    return url;
  }

  Future<OutputHandler> responseHandler(Response response) async {
    debugPrint("Status Code : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return OutputHandler(
        message: response.data['message'],
        data: response.data['data'],
        isSuccess: true,
        status: 200,
      );
    } else {
      int finder = _constants.errorOutputs
          .indexWhere((element) => element['status'] == response.statusCode);
      if (finder == -1) {
        return OutputHandler(
          message: 'Unhandled, Internal Server Error!',
          data: 0,
          isSuccess: false,
          status: 500,
        );
      } else {
        var output = _constants.errorOutputs[finder];
        return OutputHandler(
          message: output["message"],
          data: 0,
          isSuccess: false,
          status: output["status"],
        );
      }
    }
  }
}
