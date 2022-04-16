import 'package:evento_package/controllers/yourtickets.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/index.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.topbar.search.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YouTicketsScreen extends StatefulWidget {
  const YouTicketsScreen({Key? key}) : super(key: key);

  @override
  _YouTicketsScreenState createState() => _YouTicketsScreenState();
}

class _YouTicketsScreenState extends State<YouTicketsScreen> {
  final AppCss _appCss = AppCss();
  final YourTicketController _yourTicketController =
      Get.put(YourTicketController());

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _yourTicketController.getProfile();
      _yourTicketController.getTicket();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
      child: GetBuilder<YourTicketController>(
        builder: (_) =>Column(
      children: <Widget>[
        // SearchWidget(
        //   _yourTicketController.searchController,
        //   onChangeEvent: (val) => {},
        // ),
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
                    width: MediaQuery.of(context).size.width * 20 / 100,
                  ),
                  Text("Aug 18 2021",
                      style: _appCss.sh5.copyWith(letterSpacing: 0.5)),
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
                  const SizedBox(
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
        Expanded(
          flex: 1,child:RefreshIndicator(
            onRefresh: () {
              return Future.delayed(
                Duration(seconds: 1),
                    () {
                      _yourTicketController.getProfile();
                      _yourTicketController.getTicket();
                },
              );
            },
            child:
            ListView(
          padding: EdgeInsets.all(0),
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                ..._yourTicketController.ticketList.asMap().entries.map((e) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteNames().eventBooked,
                              arguments: e.value);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width *
                                    30 /
                                    100,
                                height: 110,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CommonHelper().imageNetwork(
                                      url: e.value.img.toString(),
                                      width: 100,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(width: 1),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  height: 110,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 2,
                                                bottom: 2),
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Text(
                                              e.value.category.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: _appCss.h5.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(e.value.name ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: _appCss.sh2.copyWith(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              e.value.address.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: _appCss.sh5
                                                  .copyWith(color: Colors.grey),
                                            ),
                                          ),
                                          Text(
                                            e.value.ticketNo ?? "",
                                            style: _appCss.sh5.copyWith(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      (e.key % 2) != 0
                          ? Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 8),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 60,
                                    width: double.infinity,
                                    color: Colors.pink,
                                    child: CommonHelper().imageAsset(
                                        url:
                                            'assets/images/wishlistcard_ads.png',
                                        fit: BoxFit.cover),
                                  ),
                                  Positioned(
                                    right: 50,
                                    top: 10,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "50% OFF \nAll Diamond Ring",
                                        style: _appCss.sh2.copyWith(
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      height: 18,
                                      width: 33,
                                      margin: EdgeInsets.only(top: 5),
                                      alignment: Alignment.center,
                                      color: Color(0xFFFFC121),
                                      child: Text(
                                        "Ad",
                                        style: _appCss.sh4.copyWith(
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container()
                    ],
                  );
                }),
              ],
            ),
          ],
        )))]),
      ),
    );
  }
}
