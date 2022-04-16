import 'package:evento_package/controllers/signin.controller.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:evento_package/utilities/widgets/custom.textbox.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/material.dart';
import 'package:evento_package/utilities/index.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AppCss _appCss = AppCss();

  final SignInController _signInController = Get.put(SignInController());
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () => commonHelper.onBackPressed(context),
      child: Scaffold(
        body: LoadingComponent(
          child: GetBuilder<SignInController>(
            builder: (_) => Container(
              margin: EdgeInsets.only(top: statusBarHeight),
              child: Form(
                key: _formKeys,
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 25,
                  ),
                  children: [
                    const SizedBox(height: 40),
                    Text("Hey, Login Now", style: _appCss.shMax),
                    CustomTextBox(
                      marginTop: 15,
                      onChange: (val) {},
                      headTitle: "Email or Phone number",
                      headStyle: _appCss.sh4.copyWith(color: Colors.grey),
                      controller: _signInController.emailIdORNumber,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email or phone number is required. *";
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextBox(
                      marginTop: 15,
                      onChange: (val) {},
                      obscureText: true,
                      headTitle: "Password",
                      headStyle: _appCss.sh4.copyWith(color: Colors.grey),
                      controller: _signInController.password,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required. *";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: InkWell(
                          onTap: () {
                            /*  Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ForgetPasswordScreen(),
                              ),
                            );*/

                            Get.toNamed(RouteNames().forgetPassword);
                          },
                          child: Text(
                            "Forget Password?",
                            style: _appCss.sh4.copyWith(color: Colors.orange),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomMaterialButton(
                      onTap: () {
                        if (_formKeys.currentState!.validate()) {
                          _signInController.signInEvent();
                          FocusScope.of(context).unfocus();
                        }
                      },
                      title: "Login now".toUpperCase(),
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
                              "Are you new ?",
                              style: _appCss.sh4,
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouteNames().signUp);
                              },
                              child: Text(
                                "Register Now",
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
