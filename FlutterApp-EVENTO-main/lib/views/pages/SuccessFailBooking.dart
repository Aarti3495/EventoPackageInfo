import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/checkout.details.controller.dart';
import '../../controllers/homeControllers/dashboard.controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/routes/route.names.dart';
import '../../utilities/themes/app.css.dart';
import '../../utilities/widgets/custom.material.button.dart';
import '../../utilities/widgets/custom.textbox.dart';
import '../../utilities/widgets/loading.component.dart';
class SuccessFailBooking extends StatefulWidget {
  const SuccessFailBooking({Key? key}) : super(key: key);

  @override
  State<SuccessFailBooking> createState() => _SuccessFailBookingState();
}

class _SuccessFailBookingState extends State<SuccessFailBooking> {

  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Get.back()
    );
  }

  final AppCss _appCss = AppCss();
  TextEditingController name = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   centerTitle: true,
      //   iconTheme: const IconThemeData(color: Colors.black),
      //   title: Text(
      //     "Booked".tr,
      //     style: TextStyle(color: Colors.black),
      //   ),
      // ),
      body: Stack(
        children: [
          Form(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        CustomTextBox(
                          fillColor: Colors.white,
                          marginTop: 15,
                          onChange: (val) {},
                          textInputAction: TextInputAction.next,
                          headTitle: "yourName".tr,
                          headStyle:
                          _appCss.h4.copyWith(color: Colors.grey),
                          controller: name,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Name is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTextBox(
                          fillColor: Colors.white,
                          marginTop: 15,
                          onChange: (val) {},
                          textInputAction: TextInputAction.next,
                          headTitle: "Email".tr,
                          headStyle:
                          _appCss.h4.copyWith(color: Colors.grey),
                          controller: emailId,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Email is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTextBox(
                          fillColor: Colors.white,
                          marginTop: 15,
                          onChange: (val) {},
                          textInputAction: TextInputAction.next,
                          headTitle: "phoneNumber".tr,
                          keyboardType: TextInputType.number,
                          headStyle:
                          _appCss.h4.copyWith(color: Colors.grey),
                          controller:
                          phoneNumber,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Phone number is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTextBox(
                          onChange: (val) {},
                          fillColor: Colors.white,
                          marginTop: 15,
                          textInputAction: TextInputAction.done,
                          headTitle: "Address".tr,
                          headStyle:
                          _appCss.h4.copyWith(color: Colors.grey),
                          controller: address,
                          maxLines: 4,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Address is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.85),
              child: Center(
                child: Lottie.asset('assets/images/Success.json',height: 250),
                // SpinKitWanderingCubes(
                //     color: Color.fromRGBO(32, 192, 232, 1),
                //     shape: BoxShape.circle)
              ),
            )
          ),

        ],
      ),
    );
  }
}
