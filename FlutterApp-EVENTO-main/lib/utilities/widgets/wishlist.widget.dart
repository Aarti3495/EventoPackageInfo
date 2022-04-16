import 'package:evento_package/controllers/homeControllers/dashboard.controller.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/custom.material.button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

final AppCss _appCss = AppCss();

class WishlistCard extends StatelessWidget {
  const WishlistCard(
      {Key? key,
      @required this.wishlist,
      this.ontap,
      required this.onTapDetails,
      required this.index})
      : super(key: key);

  final dynamic wishlist;
  final Function? ontap;
  final Function? onTapDetails;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: appColor.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  wishlist['category'],
                  textAlign: TextAlign.center,
                  style: _appCss.sh5.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 120,
                      height: 110,
                      // decoration: ,
                      child: AspectRatio(
                        aspectRatio: 0.90,
                        child: Container(
                          child: CommonHelper().imageNetwork(
                              url: Constants().imageUrl + wishlist['img'],
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          wishlist['name_ev'],
                          style: _appCss.sh3.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          wishlist['place_ev'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: _appCss.sh5.copyWith(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder(
                            future: DashboardController.dashboardFind
                                .convertPrice(wishlist['price_ev'].toInt()),
                            initialData: "",
                            builder: (BuildContext context,
                                AsyncSnapshot<String> price) {
                              return Text(
                                price.data!.toString(),
                                style: _appCss.sh4.copyWith(
                                    color: Theme.of(context).primaryColor),
                              );
                            }),
                        const SizedBox(height: 8),
                        Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width / 2,
                            color: Colors.grey[300]),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => onTapDetails!(),
                              child: Row(
                                children: [
                                  Text(
                                    'Details'.tr,
                                    style: _appCss.sh5.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 15,
                              color: Colors.grey,
                            ),
                            InkWell(
                              onTap: () => ontap!(),
                              child: Row(
                                children: [
                                  Text(
                                    'Remove'.tr,
                                    style: _appCss.sh5.copyWith(
                                      color: appColor.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Icon(
                                    Icons.clear,
                                    size: 15,
                                    color: appColor.primaryColor,
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        (index % 2) != 0
            ? Container(
                margin: EdgeInsets.fromLTRB(5, 8, 5, 8),
                child: Stack(
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      color: Colors.pink,
                      child: CommonHelper().imageAsset(
                          url: 'assets/images/wishlistcard_ads.png',
                          fit: BoxFit.cover),
                    ),
                    Positioned(
                      right: 50,
                      top: 10,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text("50% OFF \nAll Diamond Ring",
                            style: _appCss.sh2.copyWith(
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold)),
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
  }
}
