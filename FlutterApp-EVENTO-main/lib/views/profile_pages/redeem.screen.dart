import 'package:evento_package/controllers/profileControllers/profile.controller.dart';
import 'package:evento_package/controllers/redeem.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:evento_package/utilities/widgets/custom.textbox.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RedeemScreen extends StatefulWidget {
  const RedeemScreen({Key? key}) : super(key: key);

  @override
  _RedeemScreenState createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  final AppCss _appCss = AppCss();
  final RedeemController _redeemController = Get.put(RedeemController());

  dynamic redeem = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _redeemController.fetchTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
      child: Scaffold(
        backgroundColor: Color(0xFFefefef),
        appBar: AppBar(
          backgroundColor: Constants().topBarColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text("Redeem Coin".tr,
              style: _appCss.sh3.copyWith(color: Colors.white)),
          actions:  [
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: IconButton(icon: Icon(Icons.refresh),onPressed: (){
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  _redeemController.fetchTransaction();
                });
              }),
            )
          ],
        ),
        body: GetBuilder<RedeemController>(
          builder: (_) => Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: Constants().topBarColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10, bottom: 10),
                              color: appColor.primaryColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("youHave".tr,
                                          style: _appCss.sh4.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          ProfileController.profileController
                                                  .user['coins'] +
                                              " F - Coin",
                                          style: _appCss.sh3.copyWith(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/1.1.1.3/coins (1) 1.svg",
                                    width: 50,
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _redeemController.redeemList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 3, left: 20, right: 20, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          // decoration: ,
                                          child: AspectRatio(
                                            aspectRatio: 0.90,
                                            child: Container(
                                              child: CommonHelper().imageNetwork(
                                                  url: _redeemController
                                                          .redeemList[index][
                                                      "img"]) /*SvgPicture.asset(_redeemController.redeemList[index]["icon"])*/,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _redeemController
                                                      .redeemList[index]
                                                  ["translation_type"],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: _appCss.sh3.copyWith(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              _redeemController
                                                  .redeemList[index]["details"],
                                              style: _appCss.sh5
                                                  .copyWith(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          _redeemController.redeemList[index]
                                                      ["translation_type"] ==
                                                  "Coin Redeem"
                                              ? "-" +
                                                  _redeemController
                                                          .redeemList[index]
                                                      ["Amount"]
                                              : "+" +
                                                  _redeemController
                                                          .redeemList[index]
                                                      ["Amount"],
                                          style: _appCss.sh3.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: _redeemController
                                                              .redeemList[index]
                                                          [
                                                          "translation_type"] ==
                                                      "Coin Redeem"
                                                  ? Colors.red
                                                  : Colors.green),
                                        ),
                                        Text(
                                          CommonHelper().dateformate(
                                              _redeemController
                                                  .redeemList[index]["date"]),
                                          style: _appCss.sh5.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomMaterialButton(
                  onTap: () {
                    if (double.parse(ProfileController
                            .profileController.user['coins']) ==
                        0.0) {
                      CommonHelper().errorMessage(
                          "Your coin amount is 0 and you need to have 100 coins to redeem");
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return const RedeemCoinPopup();
                        },
                      );
                    }
                  },
                  title: "redeem".tr,
                  padding: 10,
                  radius: 0,
                  style: _appCss.sh2.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RedeemCoinPopup extends StatefulWidget {
  const RedeemCoinPopup({Key? key}) : super(key: key);

  @override
  _RedeemCoinPopupState createState() => _RedeemCoinPopupState();
}

class _RedeemCoinPopupState extends State<RedeemCoinPopup> {
  dynamic redeem = 0;
  double redeemDollar = 0.0;
  final AppCss _appCss = AppCss();
  final TextEditingController _upiIdController = TextEditingController();
  final RedeemController _redeemController = Get.put(RedeemController());
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _redeemController.convertPrice(1);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RedeemController>(
      builder: (_) => AlertDialog(
        backgroundColor: Constants().topBarColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Redeem your coin".tr,
              style: _appCss.sh2.copyWith(color: Colors.white),
            ),
            InkWell(
              child: const Icon(Icons.close, color: Colors.white),
              onTap: () {
                Get.back();
              },
            )
          ],
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 0),
        titlePadding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
        contentPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        content: Form(
        key: _formKeys,child: SizedBox(
          width: MediaQuery.of(context).size.width * 83 / 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SfSlider(
                min: 0,
                max: double.parse(ProfileController
                            .profileController.user['coins']) ==
                        0.0
                    ? 50
                    : double.parse(
                        ProfileController.profileController.user['coins']),
                value: redeem,
                interval: 10,
                showTicks: false,
                showLabels: false,
                enableTooltip: false,
                activeColor: Colors.orange,
                inactiveColor: Colors.grey,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {
                    redeem = value;
                    redeemDollar = redeem * _redeemController.dollar_value;
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You will be charge 10% of amount you redeem (' +
                          ProfileController.profileController.user['coins'] +
                          ")".tr,
                      style: _appCss.h5.copyWith(color: Colors.white),
                    ),
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/1.1.1.3/coins (1) 1.svg",
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                redeem.toInt().toString() + ' Coin',
                                style:
                                    _appCss.sh3.copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                          Text(
                            '\$' + redeemDollar.toStringAsFixed(2),
                            style: _appCss.sh3.copyWith(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                    CustomTextBox(
                      marginTop: 15,
                      radius: 0.0,
                      onChange: (val) {},
                      hintText: 'UPI ID'.tr,
                      hintStyle: _appCss.sh3.copyWith(color: Colors.grey),
                      controller: _upiIdController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "UPI ID is required. *";
                        } else if (CommonHelper().isValidateUPI(value) == false) {
                          return "Invalid UPI ID";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomMaterialButton(
                      onTap: () {
                        if (_formKeys.currentState!.validate()) {
                          print(redeem);
                          var coin=int.parse('${redeem.toInt()}');
                          if( coin<101){
                            CommonHelper().errorMessage("Your coin amount is ${redeem.toInt()} and you need to have 100 coins to redeem");
                          }else {
                            _redeemController.addredeem(
                                _upiIdController.text, redeem);
                          }
                        }
                      },
                      title: "redeem".tr,
                      padding: 10,
                      radius: 0,
                      style: _appCss.sh2.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
  T? cast<T>(x) => x is T ? x : null;
}
