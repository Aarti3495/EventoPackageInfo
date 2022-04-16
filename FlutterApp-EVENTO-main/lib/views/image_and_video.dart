import 'package:evento_package/controllers/entertainment.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/views/pages/entertainment.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageAndVideo extends StatefulWidget {
  dynamic data;
  int tabScroll;
  ImageAndVideo(this.data, this.tabScroll);

  @override
  _ImageAndVideoState createState() => _ImageAndVideoState(data, tabScroll);
}

class _ImageAndVideoState extends State<ImageAndVideo>
    with SingleTickerProviderStateMixin {
  final AppCss _appCss = AppCss();
  final EntertainmentController _entertainmentController =
      Get.put(EntertainmentController());
  dynamic data;
  int tabScroll;
  _ImageAndVideoState(this.data, this.tabScroll);

  @override
  void initState() {
    _entertainmentController.load(data, tabScroll);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _entertainmentController.getProfile();
      _entertainmentController.getEventImage();
      _entertainmentController.getEventVideo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: statusBarHeight,
              left: 15,
              right: 20,
              bottom: 5,
            ),
            decoration: BoxDecoration(
                color: Constants().topBarColor,
                border: Border.all(
                  color: Constants().topBarColor,
                  width: 0,
                )),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 13,
                bottom: 13,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Entertainment",
                    style: _appCss.sh2.copyWith(
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Entertainment(),
          )
        ],
      ),
    );
  }
}
