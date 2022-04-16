import 'dart:ffi';

import 'package:evento_package/controllers/searchControllers/search.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/widgets/custom.textbox.dart';
import 'package:evento_package/utilities/widgets/event_cards/partner_company_card.dart';
import 'package:evento_package/utilities/widgets/event_cards/personal_skill_card.dart';
import 'package:evento_package/utilities/widgets/event_cards/place_card.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<SearchScreen>{
  final _dController = Get.put(SearchController());
  late TabController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _controller =
        TabController(length: _dController.drpdownItems.length, vsync: this);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      var data = _dController.drpdownItems[0];
      _dController.onItemSelected(data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadingComponent(
      child: GetBuilder<SearchController>(
        builder: (_) => Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Constants().topBarColor,
              border:
              Border.all(color: Constants().topBarColor, width: 0)),
          child: TabBar(
            padding: const EdgeInsets.all(0),
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Theme.of(context).primaryColor,
            controller: _controller,
            onTap: (index) {
              var data = _dController.drpdownItems[index];
              _dController.onItemSelected(data);
            },
            tabs: [
              ..._dController.drpdownItems.map((e) {
                return Tab(
                  child: Text(
                    e['title'].toString().tr,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              left: 25, top: 15, right: 25, bottom: 10),
          child: CustomTextBox(
            controller: _dController.search,
            marginTop: 0,
            onChange: (val) => _dController.onSearch(),
            fillColor: Colors.white,
            hintText: "search".tr,
            hintStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      Expanded(
      flex: 1,
          child: ListView(
          physics: new ClampingScrollPhysics(),
          padding: EdgeInsets.all(0),
          children: [
            Column(
              children: [
                if (_dController.selectedItem == "Places")
                  ..._dController.cardList.map((e) {
                    return PlaceCard(
                      data: e,
                      onToggle: () => _dController.toogleWishlist(e, "Places"),
                      navigateTo: () =>
                          Get.toNamed(RouteNames().eventDetail, arguments: e),
                    );
                  }),
                if (_dController.selectedItem == "Professional Skills")
                  ..._dController.cardList.map((e) {
                    return PersonalSkillCard(
                        data: e,
                        onToggle: () => _dController.toogleWishlist(
                            e, "Professional Skills"),
                        navigateTo: () => Get.toNamed(
                            RouteNames().personalSkillsEventDetailScreen,
                            arguments: e));
                  }),
                if (_dController.selectedItem == "Partner Company")
                  ..._dController.cardList.map((e) {
                    return PartnerCompanyCard(
                        data: e,
                        onToggle: () =>
                            _dController.toogleWishlist(e, "Partner Company"),
                        navigateTo: () => Get.toNamed(
                            RouteNames().partnerEventDetail,
                            arguments: e));
                  }),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ],
        ))]),
      ),
    );
  }
}
