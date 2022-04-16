import 'package:carousel_slider/carousel_slider.dart';
import 'package:evento_package/controllers/fullvideocontroller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/views/videoItme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenVideo extends StatefulWidget {
  _FullScreenVideoState createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  final FullVideoController _fullvideoController =
      Get.put(FullVideoController());
  late TapDownDetails _doubleTapDetails;
  final _transformationController = TransformationController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullvideoController.onLoad();
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
              initialPage: _fullvideoController.index,
              // autoPlay: false,
            ),
            items: _fullvideoController.data.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return InteractiveViewer(
                      child: VideoApp(i['video'] != null
                          ? i['video']
                          : i['video_file'] != null
                              ? i['video_file']
                              : i['c_video_file']));
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
