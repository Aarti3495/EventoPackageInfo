import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatInputComponent extends StatefulWidget {
  final Function(String)? onSubmitted;
  final String? durationTime;

  const ChatInputComponent({Key? key, this.onSubmitted, this.durationTime})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatInputComponentState();
}

class _ChatInputComponentState extends State<ChatInputComponent> {
  TextEditingController editingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    editingController.clear();
    editingController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ("MESSAGE".tr) + "...",
                  ),
                  focusNode: focusNode,
                  textInputAction: TextInputAction.send,
                  controller: editingController,
                  onSubmitted: sendMessage,
                )),
                IconButton(
                  icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    sendMessage(editingController.text);
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

  bool get isTexting => editingController.text.length != 0;

  void sendMessage(String message) {
    widget.onSubmitted!(message);
    editingController.text = '';
    focusNode.unfocus();
  }
}
