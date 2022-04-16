import 'package:evento_package/controllers/history.controller.dart';
import 'package:evento_package/controllers/profileControllers/wishlist.controller.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:evento_package/utilities/widgets/wishlist.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utilities/constants.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final AppCss _appCss = AppCss();

  final WishlistController _wishlistController = Get.put(WishlistController());

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _wishlistController.fetch();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
      child: Scaffold(
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Constants().topBarColor),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text("Wishlist".tr,
                style: _appCss.sh3.copyWith(color: Colors.black))),
        body: GetBuilder<WishlistController>(
          builder: (_) => Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[200],
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 20, right: 20),
              itemCount: _wishlistController.wishList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      top: index == 0 ? 20 : 0,
                      bottom: index == _wishlistController.wishList.length - 1
                          ? 20
                          : 0),
                  child: WishlistCard(
                      wishlist: _wishlistController.wishList[index],
                      ontap: () {
                        _wishlistController.removeFromWishlist(
                            _wishlistController.wishList[index]['wishId']);
                      },
                      onTapDetails: () {
                        _wishlistController.getEventDetails(
                            _wishlistController.wishList[index]);
                      },
                      index: index),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
