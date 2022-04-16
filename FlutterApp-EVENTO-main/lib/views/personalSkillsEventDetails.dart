import 'package:evento_package/controllers/homeControllers/dashboard.controller.dart';
import 'package:evento_package/controllers/homeControllers/event.details.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.textbox.dart';
import 'package:evento_package/utilities/widgets/event_cards/basic_card.dart';
import 'package:evento_package/utilities/widgets/event_cards/social_cards.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:evento_package/views/videoThumbNailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'image_and_video.dart';

class PersonalSkillsEventDetailScreen extends StatefulWidget {
  const PersonalSkillsEventDetailScreen({Key? key}) : super(key: key);

  @override
  State<PersonalSkillsEventDetailScreen> createState() =>
      _PersonalSkillsEventDetailScreenState();
}

class _PersonalSkillsEventDetailScreenState
    extends State<PersonalSkillsEventDetailScreen> {
  final _controller = Get.put(EventDetailController());
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  final AppCss _appCss = AppCss();
  late GoogleMapController mapController;
  bool isVisibleGoogleMap = false;
  LatLng _center = LatLng(45.521563, -122.677433);
  List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    _controller.onLoad();
    _controller.prepareRating(_controller.data['PersonalSkillRating']);
    if (_controller.data["let"] != null && _controller.data["long"] != null) {
      isVisibleGoogleMap = true;
      _center = LatLng(double.parse(_controller.data["let"]),
          double.parse(_controller.data["long"]));
      _markers.add(Marker(
        markerId: MarkerId(_controller.data['name']),
        position: _center,
      ));
    } else {
      isVisibleGoogleMap = false;
    }
    setState(() {});
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    print("PersonalSkills Event Detail ====== ${_controller.data}");
    return LoadingComponent(
      child: GetBuilder<EventDetailController>(
        builder: (_) => Scaffold(
          body: _controller.data != null
              ? Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.05,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CommonHelper().imageNetwork(
                                            url: _controller.data['Photo'] !=
                                                        null &&
                                                    _controller.data['Photo']
                                                            .length >
                                                        0
                                                ? Constants().imageUrl +
                                                    _controller.data['Photo'][0]
                                                        ['photo_file']
                                                : '',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.05,
                                          width: double.infinity,
                                          color: Colors.black54,
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: statusBarHeight),
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                  color: Colors.white,
                                                  icon: const Icon(
                                                      Icons.arrow_back),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      color: Colors.white,
                                                      icon: SvgPicture.asset(
                                                        "assets/icons/1.1/share.svg",
                                                        height: 20,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        CommonHelper().shareOption(
                                                            imageUrl: _controller
                                                                    .data['Company_photo'][0][
                                                                'c_photo_file'],
                                                            name: _controller
                                                                .data['name'],
                                                            category: _controller
                                                                    .data[
                                                                'pro_category'],
                                                            address: _controller
                                                                    .data[
                                                                'com_address'],
                                                            price: _controller.data['work_price'] ??
                                                                '0',
                                                            eventLink: Constants()
                                                                    .apiUrl +
                                                                "personalskill_get_list/" +
                                                                _controller
                                                                    .data["perskillId"]
                                                                    .toString());
                                                      },
                                                    ),
                                                    const SizedBox(width: 10),
                                                    IconButton(
                                                      color: Colors.white,
                                                      icon: SvgPicture.asset(
                                                        "assets/icons/1.1/Wishlist.svg",
                                                        height: 20,
                                                        color: _controller
                                                                        .data !=
                                                                    null &&
                                                                _controller.data[
                                                                        'whishlist_status'] ==
                                                                    true
                                                            ? Colors.red
                                                            : Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        _controller.toogleWishlist(
                                                            "Professional Skills");
                                                      },
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 20,
                                          left: 20,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              RatingBarIndicator(
                                                rating: _controller.ratingValue,
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 30.0,
                                                unratedColor:
                                                    Colors.grey.shade300,
                                                direction: Axis.horizontal,
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                _controller.data['name'],
                                                style: _appCss.sh1.copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Container(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8,
                                                      right: 8,
                                                      top: 3,
                                                      bottom: 3,
                                                    ),
                                                    child: Text(
                                                      _controller.data[
                                                              'profession'] ??
                                                          "",
                                                      style: _appCss.sh5
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing:
                                                                  0.5),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    color:
                                                        const Color(0xFFe58f0d),
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8,
                                                      right: 8,
                                                      top: 3,
                                                      bottom: 3,
                                                    ),
                                                    child: Text(
                                                      _controller.data[
                                                                      'live'] !=
                                                                  null &&
                                                              _controller.data[
                                                                      'live'] ==
                                                                  true
                                                          ? "Available".tr
                                                          : 'Not Available'.tr,
                                                      style: _appCss.sh5
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing:
                                                                  0.5),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(20),
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Text('Photo Gallery'.tr,
                                                  style: _appCss.sh4.copyWith(
                                                      color: Colors.blueGrey,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              const SizedBox(height: 5),
                                              Container(
                                                height: 100,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemCount: _controller
                                                      .data['Company_photo']
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    // final record = records[index];
                                                    var url = _controller.data[
                                                            'Company_photo']
                                                        [index]["c_photo_file"];
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            RouteNames()
                                                                .fullImageScreen,
                                                            arguments: [
                                                              _controller.data[
                                                                  'Company_photo'],
                                                              index
                                                            ]);
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 8),
                                                        width: 100,
                                                        height: 100,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          child: CommonHelper()
                                                              .imageNetwork(
                                                                  url: Constants()
                                                                          .imageUrl +
                                                                      url,
                                                                  fit: BoxFit
                                                                      .cover),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(ImageAndVideo(
                                                      _controller.data, 0));
                                                },
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 15,
                                                  ),
                                                  child: Text(
                                                      'View all Images'.tr,
                                                      style: _appCss.sh5
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800)),
                                                ),
                                              ),
                                              Text(
                                                'Video Gallery'.tr,
                                                style: _appCss.sh4.copyWith(
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Container(
                                                height: 100,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemCount: _controller
                                                      .data['Company_video']
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    // final record = records[index];
                                                    var url = _controller.data[
                                                            'Company_video']
                                                        [index]['c_video_file'];
                                                    return Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 8),
                                                        width: 100,
                                                        height: 100,
                                                        child: ThumbNailImage(
                                                            url,
                                                            index,
                                                            _controller.data[
                                                                'Company_video'],false) /*VideoApp(url)*/
                                                        );
                                                  },
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(ImageAndVideo(
                                                      _controller.data, 1));
                                                },
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 15,
                                                  ),
                                                  child: Text(
                                                    'View all Video'.tr,
                                                    style: _appCss.sh5.copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Price of Location'.tr,
                                                style: _appCss.sh4.copyWith(
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              (_controller.data['equip_name'] != null)?
                                              BasicCard(
                                                leadingText: _controller
                                                    .data['equip_name']
                                                    .toString(),
                                                leadingColor:
                                                    const Color(0xFF000000)
                                                        .value,
                                                trailingText: _controller
                                                    .data['equip_price']
                                                    .toString(),
                                                trailingColor: Theme.of(context)
                                                    .primaryColor
                                                    .value,
                                              ):Container(),
                                              const SizedBox(height: 10),
                                              _controller.data['decor'] != null
                                                  ? BasicCard(
                                                      leadingText: _controller
                                                          .data['decor']
                                                          .toString(),
                                                      leadingColor: const Color(
                                                              0xFF000000)
                                                          .value,
                                                      trailingText: _controller
                                                          .data['decor_price']
                                                          .toString(),
                                                      trailingColor:
                                                          Theme.of(context)
                                                              .primaryColor
                                                              .value,
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height:
                                                    _controller.data['decor'] !=
                                                            null
                                                        ? 25
                                                        : 0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Visibility(
                                              visible: isVisibleGoogleMap,
                                              child: Container(
                                                height: 175,
                                                margin:
                                                    EdgeInsets.only(bottom: 25),
                                                child: Stack(
                                                  children: [
                                                    GoogleMap(
                                                      zoomControlsEnabled:
                                                          false,
                                                      onMapCreated:
                                                          _onMapCreated,
                                                      mapToolbarEnabled: false,
                                                      markers: Set<Marker>.of(
                                                          _markers),
                                                      initialCameraPosition:
                                                          CameraPosition(
                                                        target: _center,
                                                        zoom: 13.0,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 10,
                                                      bottom: 10,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          var url =
                                                              "https://www.google.com/maps/search/?api=1&query=${_center.latitude},${_center.longitude}";
                                                          if (await canLaunch(
                                                              url)) {
                                                            await launch(url);
                                                          } else {
                                                            throw 'Could not launch $url';
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          color: Colors.white,
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/icons/1.4/map.svg",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'Social Media'.tr,
                                                        style: _appCss.sh4
                                                            .copyWith(
                                                          color:
                                                              Colors.blueGrey,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      SocialCard(
                                                        icon:
                                                            'assets/icons/1.4/fb.svg',
                                                        link: _controller
                                                            .data['facebook'],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      SocialCard(
                                                        icon:
                                                            'assets/icons/1.4/twitter.svg',
                                                        link: _controller
                                                            .data['twitter'],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      SocialCard(
                                                          icon:
                                                              'assets/images/instagram.png',
                                                          link:
                                                              _controller.data[
                                                                  'instagram']),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 30),
                                                  Text(
                                                      'Rate Your Experience?'
                                                          .tr,
                                                      style: _appCss.sh3
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800)),
                                                  const SizedBox(height: 15),
                                                  Form(
                                                    key: _formKeys,
                                                    child: Column(
                                                      children: [
                                                        Center(
                                                          child:
                                                              RatingBar.builder(
                                                            onRatingUpdate:
                                                                (val) {
                                                              _controller
                                                                      .userRating =
                                                                  val;
                                                            },
                                                            allowHalfRating:
                                                                false,
                                                            initialRating: 1,
                                                            maxRating: 5,
                                                            minRating: 1,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              );
                                                            },
                                                            itemCount: 5,
                                                            itemSize: 50.0,
                                                            unratedColor:
                                                                Colors.grey,
                                                            direction:
                                                                Axis.horizontal,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 15),
                                                        CustomTextBox(
                                                          marginTop: 15,
                                                          onChange: (val) {},
                                                          fillColor:
                                                              const Color(
                                                                  0xFFe9eaee),
                                                          headTitle:
                                                              "yourName".tr,
                                                          headStyle: _appCss.h5
                                                              .copyWith(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          controller:
                                                              _controller.name,
                                                          validator: (val) {
                                                            if (val!.isEmpty) {
                                                              return "Name is required";
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                        CustomTextBox(
                                                          marginTop: 15,
                                                          onChange: (val) {},
                                                          fillColor:
                                                              const Color(
                                                                  0xFFe9eaee),
                                                          headTitle: "Email".tr,
                                                          headStyle: _appCss.h5
                                                              .copyWith(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          controller:
                                                              _controller.email,
                                                          validator: (val) {
                                                            if (val!.isEmpty) {
                                                              return "Email is required";
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                        CustomTextBox(
                                                          marginTop: 15,
                                                          onChange: (val) {},
                                                          fillColor:
                                                              const Color(
                                                                  0xFFe9eaee),
                                                          maxLines: 4,
                                                          headTitle:
                                                              "Review".tr,
                                                          headStyle: _appCss.h5
                                                              .copyWith(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          controller:
                                                              _controller
                                                                  .review,
                                                          validator: (val) {
                                                            if (val!.isEmpty) {
                                                              return "Review is required";
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 25),
                                                        TextButton(
                                                          onPressed: () {
                                                            if (_formKeys
                                                                .currentState!
                                                                .validate()) {
                                                              _controller.addRating(
                                                                  _controller
                                                                          .data[
                                                                      "perskillId"],
                                                                  2);
                                                            }
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'SubmitReview'
                                                                    .tr,
                                                                style: _appCss
                                                                    .sh4
                                                                    .copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                ),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                size: 15,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(0),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 4,
                                          color: Color.fromRGBO(0, 0, 0, 0.16),
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FutureBuilder(
                                            future: DashboardController
                                                .dashboardFind
                                                .convertPrice((_controller.data['price']!=null)?_controller.data['price'].toInt():0),
                                            initialData: "",
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String> price) {
                                              return Text(
                                                price.data!.toString(),
                                                style: _appCss.sh3.copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              );
                                            }),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              RouteNames().checkout,
                                              arguments: _controller.data,
                                            );
                                          },
                                          child: Container(
                                            color:
                                                Theme.of(context).primaryColor,
                                            padding: const EdgeInsets.all(15),
                                            child: Text("BookNow".tr,
                                                style: _appCss.sh3.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
