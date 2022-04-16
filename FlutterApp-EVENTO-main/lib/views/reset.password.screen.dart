import 'package:evento_package/controllers/resetcontoller.dart';
import 'package:evento_package/controllers/signin.controller.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:evento_package/utilities/widgets/custom.textbox.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final AppCss _appCss = AppCss();
  final ResetController _resetController = Get.put(ResetController());
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: LoadingComponent(
        child: GetBuilder<SignInController>(
          builder: (_) => Form(
            key: _formKeys,
            child: Container(
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
                  Expanded(
                    child: ListView(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 5),
                      children: [
                        Text("Reset Password".tr, style: _appCss.shMax),
                        CustomTextBox(
                          marginTop: 30,
                          obscureText: true,
                          onChange: (val) {},
                          fillColor: const Color(0xFFe9eaee),
                          textInputAction: TextInputAction.next,
                          headTitle: "New Password".tr,
                          headStyle: _appCss.sh5.copyWith(color: Colors.grey),
                          controller: _resetController.password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required. *";
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTextBox(
                          marginTop: 15,
                          obscureText: true,
                          onChange: (val) {},
                          fillColor: const Color(0xFFe9eaee),
                          headTitle: "Confirm Password".tr,
                          textInputAction: TextInputAction.done,
                          headStyle: _appCss.sh5.copyWith(color: Colors.grey),
                          controller: _resetController.confirmPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required. *";
                            } else if (value.toString() !=
                                _resetController.password.text.toString()) {
                              return "Password doesn't match";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomMaterialButton(
                          onTap: () {
                            if (_formKeys.currentState!.validate()) {
                              _resetController.resetPassword();
                              FocusScope.of(context).unfocus();
                            }
                            //
                          },
                          title: "Submit".toUpperCase().tr,
                          padding: 10,
                          radius: 5,
                          style: _appCss.sh3.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
