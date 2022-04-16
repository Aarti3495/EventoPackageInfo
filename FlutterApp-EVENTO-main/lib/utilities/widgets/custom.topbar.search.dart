import 'package:evento_package/utilities/constants.dart';
import 'package:evento_package/utilities/widgets/custom.textbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget(this.TextEditingController,
      {Key? key, required this.onChangeEvent})
      : super(key: key);
  final TextEditingController;
  final Function(String) onChangeEvent;
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Constants().topBarColor,
        border: Border.all(color: Constants().topBarColor, width: 0),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: CustomTextBox(
        controller: widget.TextEditingController,
        marginTop: 0,
        radius: 0,
        onChange: (val) => widget.onChangeEvent(val),
        fillColor: Colors.white,
        hintText: "search".tr,
        hintStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
