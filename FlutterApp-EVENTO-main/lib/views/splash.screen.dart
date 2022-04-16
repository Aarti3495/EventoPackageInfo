import 'package:evento_package/controllers/splash.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        builder: (_) => Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 20 / 100,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                  width: 150,
                  height: 150,
                  child: null),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/vector.png"),
                        fit: BoxFit.fill),
                  ),
                  height: MediaQuery.of(context).size.width * 42 / 100,
                  child: null),
            )
          ],
        ),
      ),
    );
  }
}
