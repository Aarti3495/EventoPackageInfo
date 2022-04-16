import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/views/pages/your.tickets.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YouTicketScreen extends StatefulWidget {
  const YouTicketScreen({Key? key}) : super(key: key);

  @override
  _YouTicketScreenoState createState() => _YouTicketScreenoState();
}

class _YouTicketScreenoState extends State<YouTicketScreen>
    with SingleTickerProviderStateMixin {
  final AppCss _appCss = AppCss();

  @override
  void initState() {
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
                    "Your Tickets".tr,
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
            child: YouTicketsScreen(),
          )
        ],
      ),
    );
  }
}
