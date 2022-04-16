import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:intl/intl.dart';

import 'single_bubble_widget.dart';

class ChatBubblesWidget extends StatelessWidget {
  const ChatBubblesWidget({
    Key? key,
    required this.message,
  }) : super(key: key);
  final Map<String, dynamic> message;

  @override
  Widget build(BuildContext context) {
    final time =
        DateFormat.Hm().format(DateTime.parse(message["timestamp"].toString()));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Column(
        children: [
          SingleBubbleWidget(
            message: message["message"],
            time: time,
            color: const Color(0xFFD1D1D1),
            mainAxisAlignment: MainAxisAlignment.end,
            bubbleType: BubbleType.sendBubble,
          ),
          SingleBubbleWidget(
            message: message["reply"],
            time: time,
          )
        ],
      ),
    );
  }
}
