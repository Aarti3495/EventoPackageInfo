import 'package:evento_package/controllers/eventbook.controller.dart';
import 'package:evento_package/controllers/signup.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lottie/lottie.dart';

class EventBookedScreen extends StatefulWidget {
  const EventBookedScreen({Key? key}) : super(key: key);

  @override
  _EventBookedScreenState createState() => _EventBookedScreenState();
}

class _EventBookedScreenState extends State<EventBookedScreen> {
  final AppCss _appCss = AppCss();
  final EventBookController _eventBookController =
      Get.put(EventBookController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventBookController.onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9EAEE),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                color: Constants().topBarColor,
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        splashRadius: 2,
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    Text("Booked".tr,
                        textAlign: TextAlign.center,
                        style: _appCss.sh1.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
                left: 40,
                right: 40,
                top: MediaQuery.of(context).size.height / 5.2),
            child: Card(
              margin: EdgeInsets.only(bottom: 20),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_eventBookController.data.name ?? "",
                              style: _appCss.sh1.copyWith(
                                  color: appColor.primaryColor,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(
                            "TranId",
                            style: _appCss.sh3.copyWith(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _eventBookController.data.transId ?? "",
                            style: _appCss.sh2.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Ticket No",
                            style: _appCss.sh3.copyWith(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _eventBookController.data.ticketNo ?? "",
                            style: _appCss.sh2.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "You Payed",
                            style: _appCss.sh3.copyWith(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _eventBookController.data.amount.toString(),
                            style: _appCss.sh2.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Please this ticket at the entrance",
                            style: _appCss.sh4.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                          height: 30,
                          width: 20,
                          decoration: const BoxDecoration(
                            color: Color(0xffE9EAEE),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          )),
                      const Expanded(
                        child: Divider(
                          color: Color(0xffE9EAEE),
                          height: 5,
                          thickness: 3,
                        ),
                      ),
                      Container(
                          height: 30,
                          width: 20,
                          decoration: const BoxDecoration(
                            color: Color(0xffE9EAEE),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          )),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: QrImage(
                            data: _eventBookController.data.ticketNo.toString(),
                            version: QrVersions.auto,
                            size: 150,
                            gapless: false,
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => Get.toNamed(RouteNames.talkWithOrganizer,
                              arguments: _eventBookController.data),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/2.4.1/chatting 1.svg",
                                height: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Talk with Organizer",
                                style: _appCss.sh4.copyWith(
                                  color: appColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
