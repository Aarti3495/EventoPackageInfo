import 'package:evento_package/controllers/checkout.form.controller.dart';
import 'package:evento_package/controllers/homeControllers/dashboard.controller.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:evento_package/utilities/widgets/custom.textbox.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:lottie/lottie.dart';
class CheckOutFormScreen extends StatefulWidget {
  const CheckOutFormScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutFormScreen> createState() => _CheckOutFormScreenState();
}

class _CheckOutFormScreenState extends State<CheckOutFormScreen> {
  final AppCss _appCss = AppCss();

  final CheckOutFormController _checkOutFormController =
      Get.put(CheckOutFormController());
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  late Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _checkOutFormController.onLoad();
  }

  @override
  Widget build(BuildContext context) {
    print("Data ======= ${_checkOutFormController.data}");
    return LoadingComponent(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            "Checkout".tr,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: GetBuilder<CheckOutFormController>(
          builder: (_) => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.grey[200],
                    child: Form(
                      key: _formKeys,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
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
                                                _checkOutFormController
                                                        .data['category'] ??
                                                    _checkOutFormController
                                                        .data['profession'] ??
                                                    "",
                                                style: _appCss.sh5.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                              _checkOutFormController
                                                      .data['display_name'] ??
                                                  _checkOutFormController
                                                      .data['name'] ??
                                                  "",
                                              style: _appCss.sh2.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          /*   Text(
                                        _checkOutFormController
                                            .data['price'].toString() ??
                                            "0",
                                        style: _appCss.sh3.copyWith(
                                            color: const Color(0xFF27D99C),
                                            fontWeight: FontWeight.bold),
                                      ),*/
                                          FutureBuilder(
                                              future: DashboardController
                                                  .dashboardFind
                                                  .convertPrice(
                                                  (_checkOutFormController.data['price']!=null)?_checkOutFormController.data['price'].toInt():0),
                                              initialData: "",
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String> price) {
                                                return Text(
                                                  price.data!.toString(),
                                                  style: _appCss.sh3.copyWith(
                                                      color: const Color(
                                                          0xFF27D99C),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  CustomTextBox(
                                    fillColor: Colors.white,
                                    marginTop: 15,
                                    onChange: (val) {},
                                    textInputAction: TextInputAction.next,
                                    headTitle: "yourName".tr,
                                    headStyle:
                                        _appCss.h4.copyWith(color: Colors.grey),
                                    controller: _checkOutFormController.name,
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
                                    controller: _checkOutFormController.emailId,
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
                                        _checkOutFormController.phoneNumber,
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
                                    controller: _checkOutFormController.address,
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
                  ),
                ),
              ),
              CustomMaterialButton(
                onTap: () {
                  if (_formKeys.currentState!.validate()) {
                    openCheckout();
                  }
                },
                title: "Pay Now".toUpperCase().tr,
                padding: 10,
                radius: 5,
                style: _appCss.sh3.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openCheckout() async {
    _checkOutFormController
        .convertPrice((_checkOutFormController.data['price']!=null)?_checkOutFormController.data['price'].toInt():0)
        .then((value) {
      var options = {
        'key': 'rzp_test_ONkjQqwBphi9zw',
        'amount': double.parse(value).toInt().toString() + "00",
        "currency": "INR",
        'name': _checkOutFormController.data['category'],
        'description': _checkOutFormController.data['display_name'],
        'prefill': {'contact': _checkOutFormController.phoneNumber.text, 'email':_checkOutFormController.emailId.text},
        'external': {
          'wallets': ['paytm']
        }
      };
      try {
        _razorpay.open(options);
      } catch (e) {
        debugPrint('Error: e');
      }
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _razorpay.clear();
    print("SUCCESS" + response.paymentId!);

    _checkOutFormController.addTicket(response.paymentId!, "paid");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _razorpay.clear();
    print("ERROR" + response.code.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    _razorpay.clear();
    print("EXTERNAL_WALLET" + response.walletName.toString());
  }
}
