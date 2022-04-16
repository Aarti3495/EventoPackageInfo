import 'package:evento_package/controllers/home.layout.controller.dart';
import 'package:evento_package/controllers/notification.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/views/pages/dashboard.screen.dart';
import 'package:evento_package/views/pages/entertainment.screen.dart';
import 'package:evento_package/views/pages/search.screen.dart';
import 'package:evento_package/views/pages/your.tickets.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:evento_package/utilities/index.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with SingleTickerProviderStateMixin{
  final HomeLayoutController _homeLayoutController =
      Get.put(HomeLayoutController());
  final AppCss _appCss = AppCss();
  @override
  void initState() {
    super.initState();
    NotificationController().onMessageListener();
    NotificationController().onMessageOpenAppListener();
    pageList.add(DashboardScreen());
    pageList.add(SearchScreen());
    pageList.add(Entertainment());
    pageList.add(YouTicketsScreen());
  }
  List<Widget> pageList = [];
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () => commonHelper.onBackPressed(context),
      child: GetBuilder<HomeLayoutController>(
        builder: (_) => Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: statusBarHeight,
                  left: 20,
                  right: 20,
                  bottom: 5,
                ),
                decoration: BoxDecoration(
                    color: Constants().topBarColor,
                    border: Border.all(
                      color: Constants().topBarColor,
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 13,
                        bottom: 13,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_homeLayoutController.tabNames[_homeLayoutController.selectedIndex]}"
                                .tr,
                            style: _appCss.sh2.copyWith(
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(RouteNames().language);
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/1.1/language.svg",
                                ),
                              ),
                              const SizedBox(width: 20),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(RouteNames().profile);
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/1.1/Menu.svg",
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: IndexedStack(
                  index: _homeLayoutController.selectedIndex,
                  children: pageList,
                )
              )
            ],
          ),
          bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: _homeLayoutController.selectedIndex,
            onTap: (index) {
              FocusScope.of(context).requestFocus(FocusNode());
              if(index==3){
                pageList.removeLast;
                pageList.insert(index, YouTicketsScreen());
              }
              setState(() {
                _homeLayoutController.selectedIndex = index;
              });
              //_homeLayoutController.onTabChange(index);
            },
            reverse: false,
            inactiveColor: Colors.grey,
            activeColor: Theme.of(context).primaryColor,
            items: [
              TitledNavigationBarItem(
                title: SvgPicture.asset(
                  "assets/icons/1.1/dashboard.svg",
                  color: Colors.grey,
                ),
                icon: SvgPicture.asset(
                  "assets/icons/1.1/dashboard.svg",
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TitledNavigationBarItem(
                title: SvgPicture.asset(
                  "assets/icons/1.1/search.svg",
                  color: Colors.grey,
                ),
                icon: SvgPicture.asset(
                  "assets/icons/1.1/search.svg",
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TitledNavigationBarItem(
                title: SvgPicture.asset(
                  "assets/icons/1.1/clapperboard.svg",
                  color: Colors.grey,
                ),
                icon: SvgPicture.asset(
                  "assets/icons/1.1/clapperboard.svg",
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TitledNavigationBarItem(
                title: SvgPicture.asset(
                  "assets/icons/1.1/calendar-with-star.svg",
                  color: Colors.grey,
                ),
                icon: SvgPicture.asset(
                  "assets/icons/1.1/calendar-with-star.svg",
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
