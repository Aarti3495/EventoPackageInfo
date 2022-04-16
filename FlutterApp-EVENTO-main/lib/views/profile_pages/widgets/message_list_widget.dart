import 'dart:async';

import 'package:evento_package/controllers/helpAndSupport.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_bubbles_widget.dart';

class MessageListWidget extends StatelessWidget {
  MessageListWidget({Key? key}) : super(key: key);

  final HelpAndSupportController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(milliseconds: 100),
      () => {
        _controller.scrollController.animateTo(
          _controller.scrollController.position.maxScrollExtent + 70,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeIn,
        )
      },
    );
    return Obx(
      () => ListView.builder(
        reverse: true,
        itemCount: _controller.messageList.length,
        controller: _controller.scrollController,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return ChatBubblesWidget(message: _controller.messageList[index]);
        },
      ),
    );
  }
}
