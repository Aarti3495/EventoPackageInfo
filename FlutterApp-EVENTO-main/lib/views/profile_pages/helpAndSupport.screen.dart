import 'package:evento_package/controllers/helpAndSupport.controller.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:evento_package/utilities/widgets/ChatInputComponent.dart';
import 'package:evento_package/utilities/widgets/loading.component.dart';
import 'package:evento_package/views/profile_pages/widgets/message_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utilities/constants.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  _HelpSupportScreenState createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen>
    with SingleTickerProviderStateMixin {
  final HelpAndSupportController _helpAndSupportController =
      Get.put(HelpAndSupportController());
  late TabController _controller;
  final AppCss _appCss = AppCss();

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
    _helpAndSupportController.getMessage();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Constants().topBarColor),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "help&faq".tr,
            style: _appCss.sh3.copyWith(color: Colors.black),
          ),
        ),
        body: GetBuilder<HelpAndSupportController>(
          builder: (_) => Column(
            children: [
              Container(
                color: Colors.white,
                child: TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.black45,
                  indicatorColor: Theme.of(context).primaryColor,
                  controller: _controller,
                  tabs: [
                    Tab(
                      child: Text(
                        "HELP".tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "FAQ".tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(child: MessageListWidget()),
                        ChatInputComponent(
                          onSubmitted: (text) {
                            if (text.isNotEmpty) {
                              _helpAndSupportController.sendMessage(text);
                            }
                          },
                        )
                      ],
                    ),
                    ListView(
                      physics: new ClampingScrollPhysics(),
                      // mainAxisSize: MainAxisSize.min,
                      children: const [
                        ExpansionTile(
                          childrenPadding:
                          EdgeInsets.only(left: 15, right: 15, bottom: 10),
                          backgroundColor: Colors.white,
                          initiallyExpanded: false,
                          title: Text(
                            "What is the Evento Package App?",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            Text(
                                "With countless events on the rise, it gets difficult to know what’s hot in town. Evento Package lets you know the best places to be, in and around the country, all at the touch of your fingertips."),
                          ],
                        ),
                        SizedBox(height: 2),
                        ExpansionTile(
                          childrenPadding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 10),
                          backgroundColor: Colors.white,
                          initiallyExpanded: false,
                          title: Text(
                            "How do I set up this App?",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            Text(
                                "Pretty simple! Click on the Play store or App store and hit download Evento Package."),
                          ],
                        ),
                        SizedBox(height: 2),
                        ExpansionTile(
                          childrenPadding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 10),
                          backgroundColor: Colors.white,
                          initiallyExpanded: false,
                          title: Text(
                            "Does it cost anything to be a member?",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            Text(
                                "There are no costs of being a member, you can subscribe to the app and get all the latest events around you"
                                ),
                          ],
                        ),
                        SizedBox(height: 2),
                        ExpansionTile(
                          childrenPadding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 10),
                          backgroundColor: Colors.white,
                          initiallyExpanded: false,
                          title: Text(
                            "What is your policy regarding privacy?",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            Text(
                                "We respect your privacy and we will not share any confidential information to any party whatsoever."),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
