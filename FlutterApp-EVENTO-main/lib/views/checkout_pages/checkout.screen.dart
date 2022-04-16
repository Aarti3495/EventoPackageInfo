import 'package:evento_package/controllers/checkout.details.controller.dart';
import 'package:evento_package/controllers/homeControllers/dashboard.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final AppCss _appCss = AppCss();
  final _controller = Get.put(CheckoutDetailController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar( // Here we create one to set status bar color
              backgroundColor: Constants().topBarColor, // Set any color of status bar you want; or it defaults to your theme's primary color
              elevation: 0,
              bottomOpacity: 0.0,
            )
        ),
      body: LoadingComponent(
        child: Stack(
          children: [
            ListView(
              physics: new ClampingScrollPhysics(),
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
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
                      const SizedBox(height: 5),
                      Text("checkout1".tr,
                          textAlign: TextAlign.center,
                          style: _appCss.shMax.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: MediaQuery.of(context).size.height / 3.75),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, top: 2, bottom: 2),
                        color: appColor.primaryColor,
                        child: Text(
                          _controller.data['category'] ??
                              _controller.data['profession'] ??
                              "",
                          style: _appCss.sh4.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Event Name",
                        style: _appCss.sh4.copyWith(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _controller.data['display_name'] ??
                            _controller.data['name'] ??
                            "",
                        style: _appCss.sh1.copyWith(
                            color: appColor.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 5),
                          Expanded(
                            child: _controller.data['event'] == null
                                ? Text(
                                    _controller.data['com_address'] ?? '',
                                    style: _appCss.sh4
                                        .copyWith(fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    _controller.data['event'] != null &&
                                            _controller.data['event'].length > 0
                                        ? _controller.data['event'][0]
                                            ['address']
                                        : '',
                                    style: _appCss.sh4
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        height: 30,
                        color: Colors.grey[300],
                      ),
                      FutureBuilder(
                          future: DashboardController.dashboardFind
                              .convertPrice((_controller.data['price']!=null)?_controller.data['price'].toInt():0),
                          initialData: "",
                          builder: (BuildContext context,
                              AsyncSnapshot<String> price) {
                            return Text(
                              price.data!.toString(),
                              style: _appCss.sh2.copyWith(
                                  color: appColor.primaryColor,
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomMaterialButton(
                onTap: () {
                  Get.toNamed(RouteNames().checkOutForm,
                      arguments: _controller.data);
                },
                title: "CheckOut".toUpperCase(),
                padding: 10,
                radius: 5,
                style: _appCss.sh3.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
