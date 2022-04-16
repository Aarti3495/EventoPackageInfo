import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';

class SingleBubbleWidget extends StatelessWidget {
  SingleBubbleWidget({
    Key? key,
    required this.message,
    required this.time,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.color = Colors.white,
    this.bubbleType = BubbleType.receiverBubble,
  }) : super(key: key);
  final String message;
  final String time;
  final MainAxisAlignment mainAxisAlignment;
  final Color color;
  final BubbleType bubbleType;
  final AppCss _appCss = AppCss();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatBubble(
              clipper: ChatBubbleClipper4(type: bubbleType),
              backGroundColor: color,
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.50),
                child: Text(
                  message,
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
    );
  }
}
