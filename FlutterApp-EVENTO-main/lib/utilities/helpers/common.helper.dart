import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:evento_package/controllers/loading.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:money_converter/Currency.dart';
import 'package:money_converter/money_converter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
final _storage = GetStorage();
var loadingCtrl = Get.find<LoadingController>();

class CommonHelper {
  // READ WRITE STORAGE
  Future<dynamic> getStorage(String name) async {
    dynamic info = await _storage.read(name) ?? '';
    return info != '' ? json.decode(info) : info;
  }

  Future<dynamic> writeStorage(String key, dynamic value) async {
    dynamic object = value != null ? json.encode(value) : value;
    return await _storage.write(key, object);
  }

  removeByKeyStorage(String key) {
    _storage.remove(key);
  }

  cleanStorage() {
    _storage.erase();
  }

  // ALERT SNACK BARS
  successMessage(message) {
    return Get.rawSnackbar(
        title: "Success",
        message: message,
        backgroundColor: Colors.green.shade400,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.check),
        shouldIconPulse: true,
        instantInit: true);
  }

  topSnack(message, IconData icon, Color color) {
    return Get.rawSnackbar(
        message: message,
        backgroundColor: color,
        snackPosition: SnackPosition.TOP,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        shouldIconPulse: true,
        instantInit: true);
  }

  bottomSnack(message, Color color) {
    return Get.rawSnackbar(
        message: message,
        backgroundColor: color,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        shouldIconPulse: true,
        instantInit: true);
  }

  errorMessage(message) {
    return Get.rawSnackbar(
        title: "Error",
        message: message,
        backgroundColor: Colors.red.shade400,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.error,color: Colors.white70),
        shouldIconPulse: true,
        instantInit: true);
  }

  alertMessage(message) {
    return Get.snackbar('Alert', message,
        backgroundColor: Colors.yellow,
        colorText: Colors.black,
        borderRadius: 2,
        margin: const EdgeInsets.all(0));
  }

  // VARIABLE TEST & CONVERTER
  bool isNull(val) {
    if (val == null) {
      return true;
    } else {
      return false;
    }
  }

  bool isNullOrBlank(dynamic val) {
    if (val is List) {
      if (val.isEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      if (val == null ||
          val == '' ||
          val.toString().isEmpty ||
          val.toString().isBlank == true) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> onBackPressed(context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit from App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  bool isEmail(String str) {
    RegExp _email = RegExp(
        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
    return _email.hasMatch(str.toLowerCase());
  }

  bool isValidateUPI(String upi){

    RegExp _password =
    RegExp(r'^(.+)@(.+)$');
    return _password.hasMatch(upi.toLowerCase());
  }

  bool isPassword(String str) {
    RegExp _password =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return _password.hasMatch(str.toLowerCase());
  }

  bool isNumeric(String str) {
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    return _numeric.hasMatch(str);
  }

  bool isNumericCheck(string) {
    if (string == null || string == 'null' || string.isEmpty) {
      return false;
    }
    final number = num.tryParse(string);
    if (number == null) {
      return false;
    }
    return true;
  }

  bool isInt(String str) {
    RegExp _int = RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
    return _int.hasMatch(str);
  }

  bool isJson(str) {
    try {
      json.decode(str);
    } catch (e) {
      return false;
    }
    return true;
  }

  String removeBraces(strData) {
    String objString = "";
    strData.forEach((final String key, final value) {
      objString = objString + value[0] + "\n";
    });
    return objString.trim();
  }

  void showLoading() => loadingCtrl.showLoading();

  void hideLoading() => loadingCtrl.hideLoading();

  //WIDGETS HELPER
  Widget imageNetwork({
    required String url,
    double? height,
    double? width,
    BoxFit? fit,
    Widget? placeholder,
    String? errorImageAsset,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ??
          Center(
              child:
              // Image.asset(
              //   "assets/images/loading.gif",
              //   height: 80.0,
              // )
              Lottie.asset('assets/images/imageLoader.json',height: 130),
              // SpinKitWanderingCubes(
              //     color: Color.fromRGBO(32, 192, 232, 1),
              //     shape: BoxShape.circle)
          ),
      errorWidget: (context, url, error) => Image.asset(
        errorImageAsset ?? Constants().noImage,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget imageAsset({
    required String url,
    double? height,
    double? width,
    BoxFit? fit,
    Widget? placeholder,
    String? errorImageAsset,
  }) {
    return Image.asset(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, url, error) => Image.asset(
        errorImageAsset ?? Constants().noImage,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  /* Future<String> convertPrice({required String price}) async {
    String countryCode =
        await CommonHelper().getStorage(Constants().countryCode);
    var value;
    if (countryCode.toLowerCase() == "us") {
      var value1 = await MoneyConverter.convert(
          Currency(Currency.INR, amount: double.parse(price)),
          Currency(Currency.USD));
      value = "USD" + " " + value1!.toStringAsFixed(2).toString();
    } else if (countryCode.toLowerCase() == "fr") {
      var value1 = await MoneyConverter.convert(
          Currency(Currency.INR, amount: double.parse(price)),
          Currency(Currency.EUR));
      value = value1!.toStringAsFixed(2).toString() + " " + "EUR";
    } else if (countryCode.toLowerCase() == "hi") {
      var value1 = double.parse(price);
      value = value1!.toStringAsFixed(2).toString() + " " + "INR";
    } else if (countryCode.toLowerCase() == "de") {
      var value1 = await MoneyConverter.convert(
          Currency(Currency.INR, amount: double.parse(price)),
          Currency(Currency.EUR));
      value = value1!.toStringAsFixed(2).toString() + " " + "EUR";
    } else if (countryCode.toLowerCase() == "cn") {
      var value1 = await MoneyConverter.convert(
          Currency(Currency.INR, amount: double.parse(price)),
          Currency(Currency.CNY));
      final currencyFormatter = NumberFormat.currency(locale: 'zh');
      value = currencyFormatter.format(double.parse(price)).substring(0, 3) +
          " " +
          value1.toString();
    } else if (countryCode.toLowerCase() == "th") {
      var value1 = await MoneyConverter.convert(
          Currency(Currency.INR, amount: double.parse(price)),
          Currency(Currency.THB));
      final currencyFormatter = NumberFormat.currency(locale: 'tha');
      value = currencyFormatter.format(double.parse(price)).substring(0, 3) +
          " " +
          value1.toString();
    } else {
      var value1 = double.parse(price);
      value = value1!.toStringAsFixed(2).toString() + " " + "INR";
    }
    return value.toString();
  }*/

  /* Future<int> convertprice({required int price}) async {
    */ /*String countryCode =
        await CommonHelper().getStorage(Constants().countryCode);
    double? value;
    if (countryCode.toLowerCase() == "us") {
      value = await MoneyConverter.convert(
          Currency(Currency.INR, amount: double.parse(price)),
          Currency(Currency.USD));
    } else if (countryCode.toLowerCase() == "fr") {
      value = await MoneyConverter.convert(
          Currency(Currency.INR, amount: double.parse(price)),
          Currency(Currency.EUR));
    } else if (countryCode.toLowerCase() == "hi") {
      value = double.parse(price);
    } else if (countryCode.toLowerCase() == "de") {
      value = await MoneyConverter.convert(
          Currency(Currency.INR, amount: double.parse(price)),
          Currency(Currency.EUR));
    } else if (countryCode.toLowerCase() == "cn") {
      value = await MoneyConverter.convert(
          Currency(Currency.INR, amount: double.parse(price)),
          Currency(Currency.CNY));
    } else if (countryCode.toLowerCase() == "th") {
      value = await MoneyConverter.convert(
          Currency(Currency.INR, amount: double.parse(price)),
          Currency(Currency.THB));
    } else {
      value = double.parse(price);
    }
    return value!.toInt();*/ /*
  }*/

  Future<void> shareOption(
      {String imageUrl = "",
      String name = "",
      String category = "",
      String price = "",
      String address = "",
      String eventLink = ""}) async {
    try {
      final imageurl = Constants().imageUrl + imageUrl;
      final uri = Uri.parse(imageurl);
      final response = await http.get(uri);
      final bytes = response.bodyBytes;
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/image.jpg';
      File(path).writeAsBytesSync(bytes);
      await Share.shareFiles([path],
          text: 'Name: ' +
              name +
              "\nCategory: " +
              category +
              "\nPrice: " +
              price +
              "\nAddress: " +
              address +
              "\nEventLink: " +
              eventLink);
    } catch (e) {
      print('error: $e');
    }
  }

  prepareRating(rating) {
    if (rating != null && rating.length > 0) {
      double totalRating = 0;
      rating.forEach((item) {
        var rate = item['stars'].toString();
        totalRating += double.parse(rate);
      });
      return totalRating / rating.length;
    } else {
      return double.parse("0");
    }
  }

  String dateformate(date) {
    final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    var date_c = format.parse(date);
    final DateFormat formatter = DateFormat('MMM dd,yyyy');
    var date_n = formatter.format(date_c);
    return date_n;
  }
}
