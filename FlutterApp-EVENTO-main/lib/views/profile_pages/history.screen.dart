import 'package:evento_package/controllers/history.controller.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utilities/constants.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final AppCss _appCss = AppCss();
  final HistoryController _historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
      child: Scaffold(
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Constants().topBarColor),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            title: Text("History".tr,
                style: _appCss.sh3.copyWith(color: Colors.black))),
        body: GetBuilder<HistoryController>(
          builder: (_) => Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[200],
            padding: const EdgeInsets.only(top: 15),
            child: ListView.builder(
              itemCount: _historyController.historyList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 3, left: 10, right: 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _historyController.historyList[index]["title"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: _appCss.sh4
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5),
                              Text(
                                _historyController.historyList[index]
                                    ["description"],
                                style: _appCss.sh5.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _historyController.historyList[index]["date"],
                                style: _appCss.sh5.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                              SizedBox(height: 5),
                              Text(
                                _historyController.historyList[index]["time"],
                                style: _appCss.sh5.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
