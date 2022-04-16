import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class SendMessageWidget extends StatelessWidget {
  SendMessageWidget({
    Key? key,
    required this.onSendTap,
  }) : super(key: key);
  final void Function(String message) onSendTap;
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ("Type here".tr) + "...",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
                  onPressed: () async {
                    if (_textEditingController.text.isNotEmpty) {
                      onSendTap(_textEditingController.text);
                      _textEditingController.clear();
                    }
                  },
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
