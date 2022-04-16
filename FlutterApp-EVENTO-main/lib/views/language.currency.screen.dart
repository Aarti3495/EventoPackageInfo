import 'package:evento_package/controllers/language.currency.controller.dart';
import 'package:evento_package/utilities/index.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utilities/constants.dart';

class LanguageCurrencyScreen extends StatefulWidget {
  const LanguageCurrencyScreen({Key? key}) : super(key: key);

  @override
  State<LanguageCurrencyScreen> createState() => _LanguageCurrencyScreenState();
}

class _LanguageCurrencyScreenState extends State<LanguageCurrencyScreen> {
  final AppCss _appCss = AppCss();

  final LanguageCurrencyController _languageCurrencyController =
      Get.put(LanguageCurrencyController());

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Constants().topBarColor,),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("language".tr,
              style: _appCss.sh3.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5)),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: GetBuilder<LanguageCurrencyController>(
          builder: (_) => Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[200],
            child: Stack(
              children: [
                ListView.builder(
                  itemCount:
                      _languageCurrencyController.languageCurrencyList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        _languageCurrencyController.selectIndex(index);
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  commonHelper.imageAsset(
                                    url: _languageCurrencyController
                                        .languageCurrencyList[index]["image"],
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${_languageCurrencyController.languageCurrencyList[index]["language"]}"
                                            .tr,
                                        style: _appCss.sh4.copyWith(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                      Text(
                                        "${_languageCurrencyController.languageCurrencyList[index]["currency"]}"
                                            .tr,
                                        style: _appCss.sh5.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              _languageCurrencyController
                                              .languageCurrencyList[index]
                                          ["code"] ==
                                      _languageCurrencyController.Language
                                  ? const Icon(
                                      Icons.check_circle_rounded,
                                      color: Color(0xFF13e1b0),
                                      size: 27,
                                    )
                                  : Icon(
                                      Icons.circle,
                                      color: Colors.grey[200],
                                      size: 27,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomMaterialButton(
                    onTap: () {
                      _languageCurrencyController.updateData(
                          _languageCurrencyController.index, context);
                    },
                    title: "save".tr,
                    padding: 15,
                    radius: 0,
                    style: _appCss.sh3.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
