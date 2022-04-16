import 'package:evento_package/controllers/loading.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingComponent extends StatelessWidget {
  final Widget? child;
  LoadingComponent({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //GestureDetector is for unFocus text controller when click on screen
    return Stack(
      children: [
        child!,
        GetBuilder<LoadingController>(
          builder: (ctrl) {
            return ctrl.isLoading == true
                ? /*ModalProgressHUD(inAsyncCall: ctrl.isLoading == true, child: Container())*/ Center(
                    child:
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withOpacity(0.85),
                      child: Center(
                          child: Image.asset(
                            "assets/images/loading.gif",
                            height: 125.0,
                            width: 125.0,
                          ),
                          //Lottie.asset('assets/images/loader.json',height: 250),
                          // SpinKitWanderingCubes(
                          //     color: Color.fromRGBO(32, 192, 232, 1),
                          //     shape: BoxShape.circle)
                      ),
                    )
            )
                : Container();
          },
        ),
      ],
    );
  }
}


