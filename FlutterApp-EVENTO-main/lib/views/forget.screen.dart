import 'package:evento_package/controllers/forgrtControllers/forget.controller.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:evento_package/utilities/widgets/custom.textbox.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utilities/helpers/common.helper.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final AppCss _appCss = AppCss();
  final ForgetController _forgetController = Get.put(ForgetController());
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: LoadingComponent(
        child: GetBuilder<ForgetController>(
          builder: (_) => Container(
            margin: EdgeInsets.only(top: statusBarHeight),
            child: Column(
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
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child:Form(
                    key: _formKeys,
                    child: ListView(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 5),
                    children: [
                      Text("forgetPassword".tr, style: _appCss.shMax),
                      CustomTextBox(
                        marginTop: 30,
                        onChange: (val) {},
                        headTitle: "emailId".tr,
                        fillColor: const Color(0xFFe9eaee),
                        headStyle: _appCss.sh5.copyWith(color: Colors.grey),
                        controller: _forgetController.txtEmail,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required. *";
                          } else if (CommonHelper().isEmail(value) == false) {
                            return "Invalid Email Address.";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomMaterialButton(
                        onTap: () {
                          if (_formKeys.currentState!.validate()){
                            _forgetController.sendOtp();
                            FocusScope.of(context).unfocus();
                          }
                          },
                        title: "Send otp".toUpperCase(),
                        padding: 10,
                        radius: 5,
                        style: _appCss.sh3.copyWith(color: Colors.white),
                      ),
                    ],
                  )
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
