import 'package:carousel_slider/carousel_slider.dart';
import 'package:evento_package/controllers/fullImageController.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenImage extends StatefulWidget {
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  final FullImageController _fullImageController =
      Get.put(FullImageController());
  late TapDownDetails _doubleTapDetails;
  final _transformationController = TransformationController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullImageController.onLoad();
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      backgroundColor: Constants().topBarColor,
      body: GestureDetector(
        onDoubleTapDown: _handleDoubleTapDown,
        onDoubleTap: _handleDoubleTap,
        child: InteractiveViewer(
          transformationController: _transformationController,
          child: CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              initialPage: _fullImageController.index,
              // autoPlay: false,
            ),
            items: _fullImageController.data.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return InteractiveViewer(
                    child: Container(
                      color: Colors.black,
                      child: Center(
                        child: CommonHelper().imageNetwork(
                            url: i["image"] != null
                                ? Constants().imageUrl + i["image"]
                                : i["c_photo_file"] != null
                                    ? Constants().imageUrl + i["c_photo_file"]
                                    : Constants().imageUrl + i["photo_file"],
                            fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
