import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../controllers/homeControllers/dashboard.controller.dart';
import '../utilities/constants.dart';
import '../utilities/themes/app.css.dart';
import '../utilities/widgets/custom.textbox.dart';
class filterScreen extends StatefulWidget {
  const filterScreen({Key? key}) : super(key: key);

  @override
  _filterScreenState createState() => _filterScreenState();
}

class _filterScreenState extends State<filterScreen> {
  final _controller = Get.put(DashboardController());
  bool _isButtonTapped = false;
  final AppCss _appCss = AppCss();

  @override
  Widget build(BuildContext context) {
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
                          for (int i = 0; i < _controller.places.length; i++) {
                            _controller.places[i]["selected"] = false;
                          }
                          _controller.priceRange.value = 0.0;
                          _controller.selectPlace = "";
                          _controller.to.text = "";
                          _controller.location.text = "";
                          _controller.from.text = "";
                          //_controller.filterClearOPtion();
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
}
