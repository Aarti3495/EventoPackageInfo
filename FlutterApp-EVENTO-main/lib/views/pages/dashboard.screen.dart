import 'package:evento_package/controllers/homeControllers/dashboard.controller.dart';
import 'package:evento_package/utilities/index.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.textbox.dart';
import 'package:evento_package/utilities/widgets/custom.topbar.search.dart';
import 'package:evento_package/utilities/widgets/event_cards/partner_company_card.dart';
import 'package:evento_package/utilities/widgets/event_cards/personal_skill_card.dart';
import 'package:evento_package/utilities/widgets/event_cards/place_card.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../utilities/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with AutomaticKeepAliveClientMixin<DashboardScreen>{
  bool _isButtonTapped = false;
  final AppCss _appCss = AppCss();
  final _controller = Get.put(DashboardController());
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _controller.search.text = "";
      _controller.searchText = '';
      _controller.fetch(true);
      _controller.getProfile();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ));
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: LoadingComponent(
        child: GetBuilder<DashboardController>(
          builder: (_) => Column(
      children: <Widget>[
        SearchWidget(
          _controller.search,
          onChangeEvent: (val) => {_controller.onSearch()},
        ),
        Container(
          // height: MediaQuery.of(context).size.height * 12.1 / 100,
          padding: const EdgeInsets.only(
              left: 20, right: 0, top: 10, bottom: 10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.orange],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, top: 1, bottom: 1),
                    child: Text(
                      "CONFERENCE",
                      style: _appCss.sh5.copyWith(
                          color: Colors.black, letterSpacing: 0.5),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Web Design Talks",
                    style: _appCss.sh1.copyWith(
                        color: Colors.white, letterSpacing: 0.5),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: Colors.white,
                    height: 1,
                    width:
                    MediaQuery.of(context).size.width * 20 / 100,
                  ),
                  Text("Aug 18 2021",
                      style:
                      _appCss.sh5.copyWith(letterSpacing: 0.5)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: commonHelper.imageNetwork(
                      url:
                      "https://image.freepik.com/free-vector/people-analyzing-growth-charts_23-2148866843.jpg",
                      width: 100,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 25,
                      width: 46,
                      alignment: Alignment.center,
                      color: Color(0xFFFFC121),
                      child: Text(
                        "ADS",
                        style: _appCss.sh4.copyWith(
                            color: Colors.black,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    alertDropDown(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding:
                    const EdgeInsets.only(left: 12, right: 12),
                    height: 50,
                    width:
                    MediaQuery.of(context).size.width * 75 / 100,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _controller.selectedItem.tr,
                          style: _appCss.sh4,
                        ),
                        SvgPicture.asset(
                          "assets/icons/1.1/drop.svg",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _controller.to.text = "";
                  _controller.from.text = "";
                  _controller.location.text = "";
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      _isButtonTapped = false;
                      return filter();
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(left: 12),
                  child:
                  const Icon(FontAwesomeIcons.filter, size: 20),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
      Expanded(
      flex: 1,child: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(
                Duration(seconds: 1),
                () {
                  _controller.search.text = "";
                  _controller.searchText = '';
                  _controller.fetch(false);
                  _controller.getProfile();
                },
              );
            },
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                Column(
                  children: [
                    if (_controller.selectedItem == "Places")
                      ..._controller.cardList.map((e) {
                        return PlaceCard(
                            data: e,
                            onToggle: () =>
                                _controller.toogleWishlist(e, "Places"),
                            navigateTo: () => Get.toNamed(
                                RouteNames().eventDetail,
                                arguments: e));
                      }),
                    if (_controller.selectedItem == "Professional Skills")
                      ..._controller.cardList.map((e) {
                        return PersonalSkillCard(
                            data: e,
                            onToggle: () => _controller.toogleWishlist(
                                e, "Professional Skills"),
                            navigateTo: () => Get.toNamed(
                                RouteNames().personalSkillsEventDetailScreen,
                                arguments: e));
                      }),
                    if (_controller.selectedItem == "Partner Company")
                      ..._controller.cardList.map((e) {
                        return PartnerCompanyCard(
                            data: e,
                            onToggle: () =>
                                _controller.toogleWishlist(e, "Partner Company"),
                            navigateTo: () => Get.toNamed(
                                RouteNames().partnerEventDetail,
                                arguments: e));
                      }),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ],
            ),
          ))]),
        ),
      ),
    );
  }

  filter() {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: AppBar( // Here we create one to set status bar color
            backgroundColor: Constants().topBarColor, // Set any color of status bar you want; or it defaults to your theme's primary color
            elevation: 0,
            bottomOpacity: 0.0,
          )
      ),
      body: GetBuilder<DashboardController>(
          builder: (_) => Container(
                color: Colors.grey.shade200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 80,
                      padding: EdgeInsets.only(top: 20, left: 20, right: 5),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filter",
                            style: _appCss.sh2,
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Get.back();
                            },
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              Text("Select Place", style: _appCss.sh3),
                              const SizedBox(height: 5),
                              Wrap(
                                children: [
                                  ..._controller.places.map((e) {
                                    return InkWell(
                                      onTap: () {
                                        _controller.onPlaceSelection(e);
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          _controller.selectedPlace(
                                              selected: e["selected"],
                                              place: e["places"]);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: e["selected"]
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.grey)),
                                          padding: const EdgeInsets.only(
                                              left: 13,
                                              right: 13,
                                              top: 10,
                                              bottom: 10),
                                          margin: const EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          child: Text(
                                            e["places"],
                                            style: _appCss.sh4.copyWith(
                                                color: e["selected"]
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.grey),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text("Person Capacity", style: _appCss.sh3),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextBox(
                                      onChange: (val) {},
                                      marginTop: 3,
                                      radius: 0,
                                      hintText: "100",
                                      textAlign: TextAlign.center,
                                      hintStyle: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF9BA0A8),
                                      ),
                                      fillColor: Colors.white,
                                      keyboardType: TextInputType.number,
                                      headStyle: _appCss.h4
                                          .copyWith(color: Colors.grey),
                                      controller: _controller.from,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      "-",
                                      style: _appCss.sh1,
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomTextBox(
                                      onChange: (val) {},
                                      marginTop: 3,
                                      radius: 0,
                                      hintText: "1200",
                                      textAlign: TextAlign.center,
                                      hintStyle: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF9BA0A8),
                                      ),
                                      fillColor: Colors.white,
                                      keyboardType: TextInputType.number,
                                      headStyle: _appCss.h4
                                          .copyWith(color: Colors.grey),
                                      controller: _controller.to,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text("Price", style: _appCss.sh3),
                              const SizedBox(height: 5),
                              Container(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _controller.priceRange
                                              .toInt()
                                              .toString() +
                                          " INR",
                                      style: _appCss.sh2.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    SfSlider(
                                      min: 0,
                                      max: 50000,
                                      value: _controller.priceRange.toDouble(),
                                      interval: 10,
                                      showTicks: false,
                                      showLabels: false,
                                      enableTooltip: false,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      inactiveColor: Colors.grey,
                                      minorTicksPerInterval: 1,
                                      onChanged: (dynamic value) {
                                        _controller.changePriceRange(value);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              CustomTextBox(
                                onChange: (val) {},
                                marginTop: 5,
                                radius: 0,
                                headTitle: "Location",
                                fillColor: Colors.white,
                                headStyle:
                                    _appCss.sh3.copyWith(color: Colors.black),
                                hintText: "Type your location slow",
                                controller: _controller.location,
                              ),
                              const SizedBox(height: 15),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _controller.fetch(true);
                              Get.back();
                            },
                            child: Container(
                              color: const Color(0xFF9ba0a8),
                              height: 50,
                              child: Center(
                                  child: Text("CANCEL",
                                      style: _appCss.sh3
                                          .copyWith(color: Colors.white))),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (!_isButtonTapped) { // only allow click if it is false
                                setState(() {
                                  _isButtonTapped = true;
                                });
                                _controller.eventFilter();
                              }
                            },
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              height: 50,
                              child: Center(
                                  child: Text("APPLY",
                                      style: _appCss.sh3
                                          .copyWith(color: Colors.white))),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
    );
  }

  alertDropDown(context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey.shade100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Who are you?".tr,
              style: _appCss.sh3,
            ),
            InkWell(
              child: SvgPicture.asset(
                "assets/icons/0.1.1/cancel.svg",
              ),
              onTap: () {
                Get.back();
              },
            )
          ],
        ),
        titlePadding: const EdgeInsets.all(15),
        contentPadding: const EdgeInsets.all(3),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 90 / 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ..._controller.drpdownItems.map((e) {
                return GestureDetector(
                  onTap: () {
                    _controller.onItemSelected(e);
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                      bottom: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 0,
                          child: SvgPicture.asset(
                            e['svgImage'],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Text(e['title'].toString().tr,
                              style: _appCss.sh4),
                        ),
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
