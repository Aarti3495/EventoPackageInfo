import 'dart:async';
import 'dart:convert';

import 'package:evento_package/controllers/talkwithorganizer.controller.dart';
import 'package:evento_package/utilities/widgets/chat.component.dart';
import 'package:evento_package/views/talk_with_organizer/widgets/sendmessage.widget.dart';
import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/helpers/common.helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TalkWithOrganizerScreen extends StatefulWidget {
  const TalkWithOrganizerScreen({Key? key}) : super(key: key);

  @override
  State<TalkWithOrganizerScreen> createState() =>
      _TalkWithOrganizerScreenState();
}

class _TalkWithOrganizerScreenState extends State<TalkWithOrganizerScreen> {
  final _controller = Get.put(TalkWithOrganizerController());

  final _channel = WebSocketChannel.connect(Uri.parse(Constants.webSocketUrl));
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final ticketData = _controller.ticketData;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          ticketData.name ?? '',
          style:
              const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.5),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<dynamic>(
                stream: _channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Timer(
                      const Duration(milliseconds: 500),
                      () => _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                    _controller
                        .addMessageToMessageList(jsonDecode(snapshot.data));
                    return Obx(
                      () => ListView.builder(
                        controller: _scrollController,
                        itemCount: _controller.messageList.length,
                        itemBuilder: (context, index) => ChatComponent(
                          chat: _controller.messageList[index]["message"],
                          isReceiver: _controller.messageList[index]["message"]
                                  ["receiver"] ==
                              ticketData.user.toString(),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ),
          SendMessageWidget(
            onSendTap: (message) async {
              final userId =
                  await CommonHelper().getStorage(Constants().userId);
              _channel.sink.add(
                jsonEncode(
                  {
                    'room': ticketData.roomName,
                    'command': 'new_message',
                    'message': message,
                    'from': userId,
                    'receiver': ticketData.receiver,
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
