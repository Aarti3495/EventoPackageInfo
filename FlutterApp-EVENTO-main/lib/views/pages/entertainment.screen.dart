import 'package:evento_package/controllers/entertainment.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/index.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.topbar.search.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../videoThumbNailScreen.dart';

class Entertainment extends StatefulWidget {
  const Entertainment({Key? key}) : super(key: key);

  @override
  _EntertainmentState createState() => _EntertainmentState();
}

class _EntertainmentState extends State<Entertainment>
    with SingleTickerProviderStateMixin ,AutomaticKeepAliveClientMixin<Entertainment>{
  late TabController _controller;
  final AppCss _appCss = AppCss();
  final EntertainmentController _entertainmentController =
      Get.put(EntertainmentController());
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    _controller = TabController(
        length: 2,
        vsync: this,
        initialIndex: _entertainmentController.tabScroll);
    _entertainmentController.tabScroll = 0;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _entertainmentController.getProfile();
      if (_entertainmentController.data == null) {
        _entertainmentController.getEventImage();
        _entertainmentController.getEventVideo();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadingComponent(
      child: GetBuilder<EntertainmentController>(
          builder:
              (_) => /*SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
              children: [
                SearchWidget(
                  _entertainmentController.searchController,
                  onChangeEvent: (val) => {},
                ),
                Container(
                  // height: MediaQuery.of(context).size.height * 12.1 / 100,
                  padding: const EdgeInsets.only(left: 20, right: 0, top: 10, bottom: 10),
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
                            padding: const EdgeInsets.only(left: 4, right: 4, top: 1, bottom: 1),
                            child: Text(
                              "CONFERENCE",
                              style: _appCss.sh5.copyWith(color: Colors.black, letterSpacing: 0.5),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Web Design Talks",
                            style: _appCss.sh1.copyWith(color: Colors.white, letterSpacing: 0.5),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            color: Colors.white,
                            height: 1,
                            width: MediaQuery.of(context).size.width * 20 / 100,
                          ),
                          Text("Aug 18 2021", style: _appCss.sh5.copyWith(letterSpacing: 0.5)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: commonHelper.imageNetwork(
                              url: "https://image.freepik.com/free-vector/people-analyzing-growth-charts_23-2148866843.jpg",
                              width: 100,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          SizedBox(width: 10,),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 25,
                              width: 46,
                              alignment: Alignment.center,
                              color: Color(0xFFFFC121),
                              child: Text(
                                "ADS",
                                style: _appCss.sh4.copyWith(color: Colors.black, letterSpacing: 0.5,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).primaryColor,
                    controller: _controller,
                    tabs: [
                      Tab(
                        child: Text(
                          "PHOTOS".tr,
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "VIDEOS".tr,
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
               Container(
                 height: MediaQuery.of(context).size.height,
                 child: TabBarView(
                     physics: NeverScrollableScrollPhysics(),
                     controller: _controller,
                     children: [
                       eventImage(),
                       eventVideo(),
                     ]),
               ),
                SizedBox(height: 20,)
              ],
            ),
        )*/
              Column(
                  children: <Widget>[
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
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.only(
                      left: 4,
                      right: 4,
                      top: 1,
                      bottom: 1),
                  child: Text(
                    "CONFERENCE",
                    style: _appCss.sh5.copyWith(
                        color: Colors.black,
                        letterSpacing: 0.5),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Web Design Talks",
                  style: _appCss.sh1.copyWith(
                      color: Colors.white,
                      letterSpacing: 0.5),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 5),
                  color: Colors.white,
                  height: 1,
                  width:
                  MediaQuery.of(context).size.width *
                      20 /
                      100,
                ),
                Text("Aug 18 2021",
                    style: _appCss.sh5
                        .copyWith(letterSpacing: 0.5)),
              ],
            ),
            Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
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
                    TabBar(
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Theme.of(context).primaryColor,
                      controller: _controller,
                      tabs: [
                        Tab(
                          child: Text(
                            "PHOTOS".tr,
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "VIDEOS".tr,
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  Expanded(
                  flex: 1,
                      child:Container(
                    child: TabBarView(
                      controller: _controller,
                      children: <Widget>[eventImage(), eventVideo()],
                    ),
                  )
                  )
                  ]),


      ),
    );
  }

  eventImage() {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(25),
      crossAxisCount: 4,
      itemCount: _entertainmentController.data == null
          ? _entertainmentController.eventImageList.length
          : _entertainmentController.data['image'] == null
              ? _entertainmentController.data['Company_photo'].length
              : _entertainmentController.data['image'].length,
      itemBuilder: (BuildContext context, int index) => Container(
        child: GestureDetector(
          onTap: () {
            Get.toNamed(RouteNames().fullImageScreen, arguments: [
              _entertainmentController.data == null
                  ? _entertainmentController.eventImageList
                  : _entertainmentController.data['Company_photo'] != null
                      ? _entertainmentController.data['Company_photo']
                      : _entertainmentController.data['image'],
              index
            ]);
          },
          child: ClipRRect(
            child: CommonHelper().imageNetwork(
                url: _entertainmentController.data == null
                    ? _entertainmentController.eventImageList[index]["image"] !=
                            null
                        ? Constants().imageUrl +
                            _entertainmentController.eventImageList[index]
                                ["image"]
                        : _entertainmentController.eventImageList[index]
                                    ["photo_file"] !=
                                null
                            ? Constants().imageUrl +
                                _entertainmentController.eventImageList[index]
                                    ["photo_file"]
                            : Constants().imageUrl +
                                _entertainmentController.eventImageList[index]
                                    ["c_photo_file"]
                    : _entertainmentController.data['Company_photo'] != null
                        ? Constants().imageUrl +
                            _entertainmentController.data['Company_photo']
                                [index]['c_photo_file']
                        : Constants().imageUrl +
                            _entertainmentController.data['image'][index]
                                ['image'],
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  eventVideo() {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(25),
      crossAxisCount: 4,
      itemCount: _entertainmentController.data == null
          ? _entertainmentController.eventVideoList.length
          : _entertainmentController.data['Company_video'] != null
              ? _entertainmentController.data['Company_video'].length
              : _entertainmentController.data['video'].length,
      itemBuilder: (BuildContext context, int index) => ThumbNailImage(
          _entertainmentController.data == null
              ? _entertainmentController.eventVideoList[index]["video"] != null
                  ? _entertainmentController.eventVideoList[index]["video"]
                  : _entertainmentController.eventVideoList[index]
                              ["video_file"] !=
                          null
                      ? _entertainmentController.eventVideoList[index]
                          ["video_file"]
                      : _entertainmentController.eventVideoList[index]
                          ["c_video_file"]
              : _entertainmentController.data['Company_video'] != null
                  ? _entertainmentController.data['Company_video'][index]
                      ['c_video_file']
                  : _entertainmentController.data['video'][index]['video'],
          index,
          _entertainmentController.data,true),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
