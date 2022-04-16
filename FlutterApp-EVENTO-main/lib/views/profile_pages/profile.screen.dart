import 'dart:io';

import 'package:evento_package/controllers/profileControllers/profile.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:evento_package/views/image_and_video.dart';
import 'package:evento_package/views/pages/your.tickets.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ticket.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AppCss _appCss = AppCss();

  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _profileController.getProfile();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar( // Here we create one to set status bar color
              backgroundColor: Constants().topBarColor, // Set any color of status bar you want; or it defaults to your theme's primary color
              elevation: 0,
              bottomOpacity: 0.0,
            )
        ),
        body: GetBuilder<ProfileController>(
          builder: (_) => Stack(
            children: [
              ListView(
                physics: new ClampingScrollPhysics(),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      splashRadius: 2,
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  _profileController.user != null
                      ? Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.transparent,
                                ),
                                child: InkWell(
                                  onTap: () async {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 45,
                                        child: ClipOval(
                                          child: _profileController.user != null
                                              ? CommonHelper().imageNetwork(
                                                  url: Constants().imageUrl +
                                                      _profileController
                                                          .user['profile_img'],
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                  width: 100)
                                              : Image.asset(
                                                  "assets/images/usera.png",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 4,
                                                right: 4,
                                                top: 2,
                                                bottom: 2),
                                            color: appColor.primaryColor,
                                            child: Text(
                                                _profileController.user != null
                                                    ? _profileController
                                                        .user['phone_no']
                                                    : '',
                                                style: _appCss.sh5.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 12)),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                              _profileController.user != null
                                                  ? _profileController
                                                      .user['name']
                                                  : '',
                                              style: _appCss.sh2.copyWith(
                                                  color: Colors.black)),
                                          Text(
                                              _profileController.user != null
                                                  ? _profileController
                                                      .user['email']
                                                  : '',
                                              style: _appCss.h5.copyWith(
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 10),
                                color: appColor.primaryColor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("youHave".tr,
                                            style: _appCss.sh4.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            _profileController.user['coins'] +
                                                " F - Coin",
                                            style: _appCss.sh3.copyWith(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    // SvgPicture.asset(
                                    //   "assets/images/profiles/Gold-coins.svg",
                                    // ),
                                    SvgPicture.asset(
                                      "assets/icons/1.1.1.3/coins (1) 1.svg",
                                      width: 50,
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(RouteNames().referEarn,
                                          arguments: _profileController.user);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/profiles_images/giftbox.svg",
                                              ),
                                              SizedBox(width: 15),
                                              Text(
                                                "ReferNEarn".tr,
                                                style: _appCss.sh4.copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Icon(Icons.arrow_forward_ios,
                                              size: 15, color: Colors.black)
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(height: 0),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(RouteNames().helpSupport);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/profiles_images/headset.svg",
                                              ),
                                              SizedBox(width: 15),
                                              Text(
                                                "help&faq".tr,
                                                style: _appCss.sh4.copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Icon(Icons.arrow_forward_ios,
                                              size: 15, color: Colors.black)
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(height: 0),
                                  InkWell(
                                    onTap: () {
                                      Get.to(ImageAndVideo(null, 1));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/profiles_images/img-group.svg",
                                              ),
                                              SizedBox(width: 15),
                                              Text(
                                                "gallery".tr,
                                                style: _appCss.sh4.copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Icon(Icons.arrow_forward_ios,
                                              size: 15, color: Colors.black)
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(height: 0),
                                  InkWell(
                                    onTap: () {
                                      Get.to(YouTicketScreen());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/profiles_images/calender.svg",
                                              ),
                                              SizedBox(width: 15),
                                              Text(
                                                "festumEnvato".tr,
                                                style: _appCss.sh4.copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Icon(Icons.arrow_forward_ios,
                                              size: 15, color: Colors.black)
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(height: 0),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(RouteNames().redeem);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/profiles_images/redeem.svg",
                                              ),
                                              SizedBox(width: 15),
                                              Text(
                                                "redeem".tr,
                                                style: _appCss.sh4.copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Icon(Icons.arrow_forward_ios,
                                              size: 15, color: Colors.black)
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const Divider(height: 0),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Get.toNamed(RouteNames().history);
                                  //   },
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         vertical: 20),
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         Row(
                                  //           mainAxisSize: MainAxisSize.min,
                                  //           children: [
                                  //             SvgPicture.asset(
                                  //               "assets/images/profiles_images/history.svg",
                                  //             ),
                                  //             SizedBox(width: 15),
                                  //             Text(
                                  //               "history".tr,
                                  //               style: _appCss.sh4.copyWith(
                                  //                   color: Colors.black,
                                  //                   fontWeight:
                                  //                       FontWeight.bold),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //         const Icon(Icons.arrow_forward_ios,
                                  //             size: 15, color: Colors.black)
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  const Divider(height: 0),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(RouteNames().wishlist);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/profiles_images/wishlist.svg",
                                              ),
                                              SizedBox(width: 15),
                                              Text(
                                                "wishlist".tr,
                                                style: _appCss.sh4.copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Icon(Icons.arrow_forward_ios,
                                              size: 15, color: Colors.black)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 100, top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () async{
                                        var whatsappUrl =
                                            "whatsapp://send?phone=+919712139000";
                                        launch(whatsappUrl);
                                        await canLaunch(whatsappUrl)? launch(whatsappUrl,forceSafariVC: false):CommonHelper().errorMessage("There is no whatsapp installed");
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/social/whatsapp.svg",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch(
                                            "https://www.facebook.com/Evento-Package-281623730303445");
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/social/fb.svg",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch("https://t.me/EventoPackage");
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/social/telegram.svg",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch(
                                            "https://www.instagram.com/EventoPackage/");
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(35),
                                        child: Image.asset(
                                          "assets/images/instagram.png",
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch(
                                            "https://twitter.com/EventoPackage");
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/social/twitter.svg",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch(
                                            "https://www.linkedin.com/company/eventopackage");
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/social/in.svg",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch(
                                            "https://www.youtube.com/channel/UCmtm1FLrLLtecvKhvu2KdHA");
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/social/youtube.svg",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomMaterialButton(
                      onTap: () async {
                        await _profileController.logout();
                      },
                      title: "logout".tr,
                      padding: 15,
                      radius: 0,
                      style: _appCss.sh3.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void lunchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
