import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageCurrencyController extends GetxController {
  var Language;
  var countryCode;

  int index = 0;

  List languageCurrencyList = [
    {
      "id": 1,
      "image": "assets/images/united-states.png",
      "language": "eng",
      "currency": "dollar",
      "code": "en",
    },
    {
      "id": 2,
      "image": "assets/images/france.png",
      "language": "europe",
      "currency": "euro",
      "code": "fr",
    },
    {
      "id": 3,
      "image": "assets/images/india.png",
      "language": "hindi",
      "currency": "indian",
      "code": "hi",
    },
    {
      "id": 4,
      "image": "assets/images/germany.png",
      "language": "german",
      "currency": "germanMark",
      "code": "de",
    },
    {
      "id": 5,
      "image": "assets/images/china.png",
      "language": "china",
      "currency": "renminbi",
      "code": "zh",
    },
    {
      "id": 6,
      "image": "assets/images/thailand.png",
      "language": "thai",
      "currency": "thaiBaht",
      "code": "tha",
    },
  ];

  void getLastUpdatedLanguage() async {
    countryCode = await CommonHelper().getStorage(Constants().countryCode);
    Language = await CommonHelper().getStorage(Constants().language);
    if (countryCode != "" && Language != "") {
      var locale = Locale(Language, countryCode);
      Get.updateLocale(locale);
    }
  }

  selectIndex(int givenIndex) {
    index = givenIndex;
    Language = languageCurrencyList[givenIndex]['code'];
    update();
  }

  updateLanguage(value, value1, context) async {
    Language = value;
    await CommonHelper().writeStorage(Constants().countryCode, value1);
    await CommonHelper().writeStorage(Constants().language, value);
    var locale = Locale(value, value1);
    Get.updateLocale(locale);
    debugPrint("Language Update Done : $locale");
  }

  updateData(index, context) {
    CommonHelper().showLoading();
    Future.delayed(const Duration(seconds: 2), () {
      if (languageCurrencyList[index]["code"] == "en") {
        updateLanguage("en", "US", context);
      } else if (languageCurrencyList[index]["code"] == "hi") {
        updateLanguage("hi", "In", context);
      } else if (languageCurrencyList[index]["code"] == "de") {
        updateLanguage("de", "DE", context);
      } else if (languageCurrencyList[index]["code"] == "zh") {
        updateLanguage("zh", "CN", context);
      } else if (languageCurrencyList[index]["code"] == "fr") {
        updateLanguage("fr", "FR", context);
      } else if (languageCurrencyList[index]["code"] == "tha") {
        updateLanguage("tha", "TH", context);
      }
      CommonHelper().hideLoading();
      debugPrint(languageCurrencyList[index]["code"]);
      debugPrint(Language);
      update();
      Get.back();
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getLastUpdatedLanguage();
    super.onInit();
  }
}
