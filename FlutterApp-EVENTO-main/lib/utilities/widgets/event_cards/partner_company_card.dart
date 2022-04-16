import 'package:evento_package/controllers/homeControllers/dashboard.controller.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:evento_package/utilities/themes/app.colors.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class PartnerCompanyCard extends StatefulWidget {
  const PartnerCompanyCard(
      {Key? key,
      required this.data,
      required this.onToggle,
      required this.navigateTo})
      : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final data;
  final Function onToggle;
  final Function navigateTo;
  @override
  _PartnerCompanyCardState createState() => _PartnerCompanyCardState();
}

class _PartnerCompanyCardState extends State<PartnerCompanyCard> {
  final AppCss _appCss = AppCss();
  IconData? _selectedIcon;

  @override
  Widget build(BuildContext context) {
    if (widget.data != null && widget.data.length > 0) {
      return Container(
        height: 310,
        margin: const EdgeInsets.only(
          bottom: 10,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: GestureDetector(
          onTap: () {
            widget.navigateTo();
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      child: ClipRRect(
                        child: CommonHelper().imageNetwork(
                          url: widget.data['photo']!=null
                              ? (Constants().imageUrl +
                                  widget.data['photo'][0]?['photo_file'])
                              : '',
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBarIndicator(
                                rating: CommonHelper().prepareRating(
                                    widget.data['PartnerCompRating']),
                                itemBuilder: (context, index) => Icon(
                                  _selectedIcon ?? Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                unratedColor: Colors.grey,
                                direction: Axis.horizontal,
                              ),
                              Text(
                                widget.data['live']
                                    ? "Available".tr
                                    : 'Not Available'.tr,
                                style: _appCss.sh4.copyWith(
                                    color: widget.data['live']
                                        ? AppColors().availableColor
                                        : AppColors().redColor),
                              )
                            ],
                          ),
                          Text(
                            widget.data['name'] ?? '',
                            style: _appCss.sh3,
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder(
                                  future: DashboardController.dashboardFind
                                      .convertPrice((widget.data['price']!=null)?
                                          widget.data['price'].toInt():0),
                                  initialData: "",
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> price) {
                                    return Text(
                                      price.data!.toString(),
                                      style: _appCss.sh3.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    );
                                  }),
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 30),
                                    Flexible(
                                      child: Text(
                                        widget.data['com_address'] ?? '',
                                        style: _appCss.sh4.copyWith(
                                          color: Colors.grey,
                                        ),
                                        softWrap: false,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    SvgPicture.asset(
                                        "assets/icons/1.1/location.svg"),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(
                      left: 4, right: 4, top: 2, bottom: 2),
                  child: Text(
                    widget.data['category'] ?? '',
                    style: _appCss.sh5.copyWith(color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    margin: const EdgeInsets.only(top: 10, right: 10),
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, top: 2, bottom: 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.onToggle();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                "assets/icons/1.1/Wishlist.svg",
                                height: 13,
                                color: widget.data['whishlist_status'] ?? false
                                    ? Colors.red
                                    : Colors.grey.shade900,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            CommonHelper().shareOption(
                                imageUrl: widget.data['Company_photo'][0]
                                    ['c_photo_file'],
                                name: widget.data['name'],
                                category: widget.data['category'],
                                address: widget.data['com_address'],
                                price: widget.data['equip_price'] ?? '0',
                                eventLink: Constants().apiUrl +
                                    "partnercompany_get_list/" +
                                    widget.data["parcomId"].toString());
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                "assets/icons/1.1/share.svg",
                                height: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
