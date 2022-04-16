import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:intl/intl.dart';

class ChatComponent extends StatelessWidget {
  final Map<String, dynamic> chat;
  final bool isReceiver;
  final bool showUser;

  ChatComponent({
    Key? key,
    required this.chat,
    this.isReceiver = false,
    this.showUser = true,
  }) : super(key: key);

  final AppCss _appCss = AppCss();

  @override
  Widget build(BuildContext context) {
    final time =
        DateFormat.Hm().format(DateTime.parse(chat["timestamp"].toString()));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment:
            isReceiver ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChatBubble(
                clipper: ChatBubbleClipper4(
                  type: isReceiver
                      ? BubbleType.receiverBubble
                      : BubbleType.sendBubble,
                ),
                backGroundColor:
                    isReceiver ? Colors.white : const Color(0xFFD1D1D1),
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.50),
                  child: Text(
                    chat["content"],
                    style: _appCss.sh4,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  time,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
