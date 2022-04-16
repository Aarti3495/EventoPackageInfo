import 'package:evento_package/controllers/signup.controller.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/themes/app.colors.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:evento_package/utilities/widgets/custom.textbox.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

AppColors appColor = new AppColors();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AppCss _appCss = AppCss();
  final SignUpController _signUpController = Get.put(SignUpController());
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'IN');

  bool isPasswordEmpty = false;
  bool isPassword = false;
  bool isCPasswordEmpty = false;
  bool isCPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingComponent(
        child: GetBuilder<SignUpController>(
          builder: (_) => ListView(
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
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Form(
                  key: _formKeys,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text("newAccount".tr, style: _appCss.shMax),
                      CustomTextBox(
                        marginTop: 15,
                        onChange: (val) {},
                        headTitle: "yourName".tr,
                        textInputAction: TextInputAction.next,
                        headStyle: _appCss.sh4.copyWith(color: Colors.grey),
                        controller: _signUpController.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Your name is required. *";
                          } else if (value[0] == "") {
                            return "White Space Not Allow. *";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextBox(
                        marginTop: 15,
                        onChange: (val) {},
                        headTitle: "Email".tr,
                        headStyle: _appCss.sh4.copyWith(color: Colors.grey),
                        controller: _signUpController.emailId,
                        textInputAction: TextInputAction.next,
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
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Text("phoneNumber".tr,
                              style: _appCss.sh4.copyWith(color: Colors.grey))),
                      Container(
                        decoration: BoxDecoration(color: Color(0xFFe9eaee)),
                        child: Row(
                          children: [
                            Expanded(
                              child: InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  phoneNumber = number;
                                },
                                onInputValidated: (bool value) {},
                                initialValue: phoneNumber,
                                selectorConfig: SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DROPDOWN,
                                ),
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle:
                                    TextStyle(color: Colors.black),
                                textFieldController:
                                    _signUpController.phoneNumber,
                                formatInput: false,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                inputBorder: InputBorder.none,
                              ),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  bool isvalid =
                                      await _signUpController.validation(
                                          phoneNumber.phoneNumber!,
                                          phoneNumber.isoCode!);
                                  print("object" + isvalid.toString());
                                  if (isvalid &&
                                      _signUpController
                                          .phoneNumber.text.isNotEmpty) {
                                    _signUpController
                                        .verificationPhoneNumber(phoneNumber);
                                  } else {
                                    _signUpController.isPhone = true;
                                    setState(() {});
                                  }
                                },
                                child: Text("verify".tr,
                                    style: _appCss.sh4
                                        .copyWith(color: Color(0xff20c0e8)))),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _signUpController.isPhone,
                        child: Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text("Phone Number is not valid",
                                style:
                                    _appCss.sh4.copyWith(color: Colors.red))),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Text("password".tr,
                              style: _appCss.sh4.copyWith(color: Colors.grey))),
                      Container(
                        decoration: BoxDecoration(color: Color(0xFFe9eaee)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _signUpController.password,
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    isPasswordEmpty = true;
                                  } else if (value.length < 8 ||
                                      value.length > 16) {
                                    isPasswordEmpty = true;
                                    isPassword = true;
                                    setState(() {});
                                  } else {
                                    isPasswordEmpty = false;
                                    isPassword = false;
                                  }
                                  setState(() {});
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                obscureText: _signUpController.passwordSecure,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _signUpController.onObscureTextChange(1);
                              },
                              child: _signUpController.passwordSecure
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.remove_red_eye,
                                      color: Color(0xff20c0e8)),
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isPasswordEmpty,
                        child: Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                                isPasswordEmpty && isPassword
                                    ? "Password should be minimum 8 characters and maximum 16 characters"
                                    : "Password is required. *",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12))),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Text("confirmPassword".tr,
                              style: _appCss.sh4.copyWith(color: Colors.grey))),
                      Container(
                        decoration: BoxDecoration(color: Color(0xFFe9eaee)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _signUpController.confirmPassword,
                                onChanged: (val) {},
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    isCPassword = true;
                                  } else if (value !=
                                      _signUpController.password.text) {
                                    isCPasswordEmpty = true;
                                  } else {
                                    isCPasswordEmpty = false;
                                    isCPassword = false;
                                  }
                                  setState(() {});
                                  return null;
                                },
                                obscureText:
                                    _signUpController.confirmPasswordSecure,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _signUpController.onObscureTextChange(2);
                              },
                              child: _signUpController.confirmPasswordSecure
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.remove_red_eye,
                                      color: Color(0xff20c0e8)),
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isPasswordEmpty,
                        child: Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                                isPasswordEmpty && isPassword
                                    ? "Password & confirm password not matched!"
                                    : "Confirm password is required. *",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12))),
                      ),
                      CustomTextBox(
                        marginTop: 15,
                        onChange: (val) {},
                        validator: (value) {
                          if (value!.isNotEmpty && value.length < 8) {
                            return "Refrence code is not valid";
                          } else {
                            return null;
                          }
                        },
                        isOptional: true,
                        headTitle: "referCode".tr,
                        textInputAction: TextInputAction.done,
                        headStyle: _appCss.sh4.copyWith(color: Colors.grey),
                        controller: _signUpController.referCode,
                      ),
                      const SizedBox(height: 35),
                      CustomMaterialButton(
                        onTap: () {
                          if (_formKeys.currentState!.validate() &&
                              !_signUpController.isPhone &&
                              !isPassword &&
                              !isPasswordEmpty &&
                              !isCPassword &&
                              !isCPasswordEmpty) {
                            if (_signUpController.verification) {
                              _signUpController.signUpRequest();
                              FocusScope.of(context).unfocus();
                            } else {
                              CommonHelper().errorMessage(
                                  "Your mobile verification is not valid..");
                            }
                          }
                        },
                        title: "Register Now".toUpperCase(),
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
                                "registerUser".tr,
                                style: _appCss.sh4,
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  "loginBTN".tr,
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
            ],
          ),
        ),
      ),
    );
  }
}
