import 'package:evento_package/controllers/otp.controller.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final AppCss _appCss = AppCss();
  final OTPController _otpController = Get.put(OTPController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _otpController.onLoad();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double statusBarHeight = MediaQuery.of(context).padding.top;
    return GetBuilder<OTPController>(
      builder: (_) => LoadingComponent(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
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
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text("Enter OTP".tr, style: _appCss.shMax),
                    const SizedBox(height: 20),
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      hintCharacter: "0",
                      hintStyle: TextStyle(fontSize: 35),
                      pastedTextStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        activeColor: Theme.of(context).primaryColor,
                        selectedColor: Theme.of(context).primaryColor,
                        inactiveColor: Color(0xFFEEEEEE),
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Color(0xFFEEEEEE),
                        activeFillColor: Colors.white,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: size.width / 6,
                        fieldWidth: size.width / 6,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: _otpController.errorController,
                      controller: _otpController.otp,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 2,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          // currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        return true;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomMaterialButton(
                      onTap: () {
                        _otpController.checkOtpEvent();
                      },
                      title: "verified".toUpperCase().tr,
                      padding: 10,
                      radius: 5,
                      style: _appCss.sh3.copyWith(color: Colors.white),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Not Get ?".tr,
                              style: _appCss.sh4,
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                "Re-Send".tr,
                                style: _appCss.sh4.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
