import 'package:evento_package/controllers/entertainment.controller.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/routes/route.names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:async';
import 'dart:typed_data';

class ThumbNailImage extends StatefulWidget {
  String url;
  int index;
  dynamic data;
  bool isEntertainmentPage=false;
  ThumbNailImage(this.url, this.index, this.data, this.isEntertainmentPage);

  @override
  _ThumnailState createState() => _ThumnailState();
}

class _ThumnailState extends State<ThumbNailImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var thumbnailRequest = ThumbnailRequest(
        video: Constants().imageUrl + widget.url,
        thumbnailPath: null,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 100,
        maxWidth: 100,
        quality: 100);
    return Container(
      child: FutureBuilder<ThumbnailResult>(
        future: genThumbnail(thumbnailRequest),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final _image = snapshot.data.image;
            return GestureDetector(
              onTap: () {
                Get.toNamed(RouteNames().fullvideoScreen, arguments: [
                  widget.data == null
                      ? EntertainmentController.entertainment.eventVideoList
                      :(this.widget.isEntertainmentPage)?(
                      widget.data['Company_video'] != null
                          ? widget.data['Company_video']
                          : widget.data['video']
                  ): widget.data,
                  widget.index
                ]);
                //    Get.to( VideoApp(widget.url));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: _image,
              ),
            );
          } else if (snapshot.hasError) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(RouteNames().fullvideoScreen, arguments: [
                  widget.data == null
                      ? EntertainmentController.entertainment.eventVideoList
                      :(this.widget.isEntertainmentPage)?(
                      widget.data['Company_video'] != null
                          ? widget.data['Company_video']
                          : widget.data['video']
                  ): widget.data,
                  widget.index
                ]);
                //Get.to( VideoApp(widget.url));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    'https://images.pexels.com/photos/2747449/pexels-photo-2747449.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class ThumbnailResult {
  final Image? image;
  final int? dataSize;
  final int? height;
  final int? width;
  const ThumbnailResult({this.image, this.dataSize, this.height, this.width});
}

Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
  //WidgetsFlutterBinding.ensureInitialized();
  Uint8List? bytes;
  final Completer<ThumbnailResult> completer = Completer();
  if (r.thumbnailPath != null) {
  } else {
    bytes = await VideoThumbnail.thumbnailData(
        video: r.video!,
        imageFormat: r.imageFormat!,
        maxHeight: r.maxHeight!,
        maxWidth: r.maxWidth!,
        quality: r.quality!);
  }

  int _imageDataSize = bytes!.length;
  print("image size: $_imageDataSize");

  final _image = Image.memory(
    bytes,
    fit: BoxFit.cover,
  );
  _image.image
      .resolve(ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    completer.complete(ThumbnailResult(
      image: _image,
      dataSize: _imageDataSize,
      height: info.image.height,
      width: info.image.width,
    ));
  }));
  return completer.future;
}

class ThumbnailRequest {
  final String? video;
  final String? thumbnailPath;
  final ImageFormat? imageFormat;
  final int? maxHeight;
  final int? maxWidth;
  final int? timeMs;
  final int? quality;

  const ThumbnailRequest(
      {this.video,
      this.thumbnailPath,
      this.imageFormat,
      this.maxHeight,
      this.maxWidth,
      this.timeMs,
      this.quality});
}
