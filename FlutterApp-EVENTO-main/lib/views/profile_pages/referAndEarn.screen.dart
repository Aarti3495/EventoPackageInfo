import 'package:clipboard/clipboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:evento_package/controllers/profileControllers/referandearn.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/index.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io' as io;

import '../../controllers/profileControllers/profile.controller.dart';
class ReferEarnScreen extends StatefulWidget {
  const ReferEarnScreen({Key? key}) : super(key: key);

  @override
  _ReferEarnScreenState createState() => _ReferEarnScreenState();
}

class _ReferEarnScreenState extends State<ReferEarnScreen> {
  final AppCss _appCss = AppCss();

  final ReferEarnController _referEarnController =
      Get.put(ReferEarnController());

  late String shareText;
  final FlutterShareMe flutterShareMe = FlutterShareMe();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _referEarnController.onLoad();
    var Username=(_referEarnController.data!=null)?_referEarnController.data["name"]:"";
    var link=(io.Platform.isAndroid)?"https://play.google.com/store/apps/details?id=com.eventopackage.evento_package"
    :"https://apps.apple.com/us/app/evento-package/id1607233336";
    shareText = "$Username has invite you to download Evento Package App \n\n Download Even to Package App: "
            "\n $link \n -------------------------------------\n Referal Code: " +
        _referEarnController.data['users_ref_code'] +
        "\n -------------------------------------" +
        "\n You will get 100 coins bonus in your account when after successfully registration with the app.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().topBarColor,
      body: ListView(
        physics: new ClampingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: 0,
        ),
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Constants().topBarColor,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Constants().topBarColor),
            ),
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  color: appColor.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("youHave".tr,
                              style: _appCss.sh4.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(_referEarnController.data['coins'] + " F - Coin",
                              style: _appCss.sh3.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SvgPicture.asset(
                        "assets/icons/1.1.1.3/coins (1) 1.svg",
                        width: 50,
                        height: 50,
                      ),
                      /*commonHelper.imageAsset(
                        width: 50,
                        height: 50,
                        url: "assets/images/coins.png",
                      ),*/
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "referDec".tr,
                  textAlign: TextAlign.center,
                  style: _appCss.shMax.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SvgPicture.asset(
                  "assets/images/profiles_images/surprise.svg",
                ),
                const SizedBox(height: 20),
                Text(
                  "referDec1".tr,
                  textAlign: TextAlign.center,
                  style: _appCss.sh1.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "referDec2".tr,
                  textAlign: TextAlign.center,
                  style: _appCss.sh3.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                DottedBorder(
                  color: const Color(0xFF16E1B0),
                  strokeWidth: 2,
                  child: Container(
                    color: const Color(0xFFC4FCEE),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    height: 80,
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Referal Code".tr),
                            Text(
                              _referEarnController.data['users_ref_code'],
                              style: _appCss.shMax.copyWith(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                                color: const Color(0xFF16E1B0),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              color: const Color(0xFF16E1B0),
                              width: 2,
                              height: 40,
                            ),
                            const SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {
                                FlutterClipboard.copy(_referEarnController
                                        .data['users_ref_code']
                                        .toString())
                                    .then((value) => print('copied'));
                                CommonHelper().successMessage('Copied');
                              },
                              child: Text(
                                "Copy\nCode".toUpperCase().tr,
                                style: _appCss.sh4.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            height: MediaQuery.of(context).size.height * 35 / 100,
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "referDec3".tr,
                    style: _appCss.sh1,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var response = await flutterShareMe.shareToWhatsApp(
                                msg: shareText);
                          },
                          child: SvgPicture.asset(
                            "assets/images/social/whatsapp.svg",
                            height: 60,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            try {
                              var response = await flutterShareMe
                                  .shareToFacebook(msg: shareText);
                            } catch (e) {
                              print("e" + e.toString());
                            }
                          },
                          child: SvgPicture.asset(
                            "assets/images/social/fb.svg",
                            height: 60,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var response = await flutterShareMe.shareToTelegram(
                                msg: shareText);
                          },
                          child: SvgPicture.asset(
                            "assets/images/social/telegram.svg",
                            height: 60,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var response = await flutterShareMe.shareToTwitter(
                                msg: shareText);
                          },
                          child: SvgPicture.asset(
                            "assets/images/social/twitter.svg",
                            height: 60,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var response = await flutterShareMe.shareToWhatsApp(
                                msg: shareText);
                          },
                          child: SvgPicture.asset(
                            "assets/images/social/sms.svg",
                            height: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Share.share(shareText);
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.only(bottom: 30, top: 5),
                        width: 120,
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                              "assets/images/social/share.svg",
                              width: 20,
                            ),
                            Text(
                              "Other".toUpperCase().tr,
                              style: _appCss.sh3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
