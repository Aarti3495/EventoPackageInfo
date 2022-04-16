import 'package:chewie/chewie.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:lottie/lottie.dart';
class VideoApp extends StatefulWidget {
  String url;

  VideoApp(this.url);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  var isLoading = false;
  late ChewieController _chewieController;

  loadVideo(String url)
  async {
    await launch(url);
  }
  @override
  void initState() {
    super.initState();
    var url = Constants().imageUrl + widget.url;
    //loadVideo(url);
    print("URL________" + url);
    setState(() {
      isLoading = true;
    });
    const len = 10000024;
    _controller = VideoPlayerController.network(url,httpHeaders: {
      'Content-Type': 'video/mp4',
      'range': 'bytes = ${len - 1}-${len - 1}',
    },)
      ..initialize().then((_) {
        _controller.seekTo(Duration(seconds: 1));
        if (_controller.value.isPlaying) {
          isLoading = false;
        }
        setState(() {
        });
      });
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: false,
    );
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants().topBarColor,
        body: isLoading
            ? Center(
                child: Lottie.asset('assets/images/imageLoader.json',height: 220),
                // Image.asset(
                //   "assets/images/loading.gif",
                //   height: 125.0,
                //   width: 125.0,
                // )
                //Lottie.asset('assets/images/loader.json',height: 250)
                // SpinKitWanderingCubes(
                //     color: Color.fromRGBO(32, 192, 232, 1),
                //     shape: BoxShape.circle)
            )
            : Container(
                color: Colors.black,
                width: double.infinity,
                height: double.infinity,
                child: Center(
                    child: Chewie(
                  controller: _chewieController,
                ))));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
