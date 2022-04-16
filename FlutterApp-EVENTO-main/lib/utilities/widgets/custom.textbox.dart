import 'package:evento_package/utilities/screen.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppScreen appScreenUtil = AppScreen();

class CustomTextBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChange;
  final bool? isOptional;
  final double marginTop;
  final String? headTitle;
  final TextStyle? headStyle;
  final TextStyle? hintStyle;
  final String? hint;
  final String? hintText;
  final String? labelText;
  final dynamic radius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final dynamic padding;
  final Color? fillColor;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;

  const CustomTextBox({
    Key? key,
    required this.controller,
    required this.marginTop,
    required this.onChange,
    this.isOptional,
    this.headTitle,
    this.headStyle,
    this.hint,
    this.hintText,
    this.labelText,
    this.radius = 5.0,
    this.prefixIcon,
    this.suffixIcon,
    this.style,
    this.hintStyle,
    this.obscureText = false,
    this.validator,
    this.padding = 10,
    this.fillColor = const Color(0xFFe9eaee),
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (headTitle != null)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$headTitle", style: headStyle),
                  if (isOptional != null && isOptional == true)
                    const Text("(Optional)",
                        style: TextStyle(fontSize: 13, color: Colors.grey))
                ],
              ),
            ),
          TextFormField(
            controller: controller,
            textAlign: textAlign,
            onChanged: (val) {
              onChange(val);
            },
            decoration: InputDecoration(
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: appScreenUtil.screenWidth(10)),
                      child: suffixIcon,
                    )
                  : null,
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: appScreenUtil.screenWidth(10)),
                      child: prefixIcon,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(appScreenUtil.borderRadius(radius)),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
              filled: true,
              fillColor: fillColor ?? const Color(0xFFF5F6FA),
              contentPadding:
                  EdgeInsets.all(appScreenUtil.screenWidth(padding)),
              hintText: hintText,
              hintStyle: hintStyle,
              labelText: labelText,
            ),
            style: style,
            autofocus: false,
            obscureText: obscureText,
            textInputAction: textInputAction,
            validator: validator,
            keyboardType: keyboardType,
            maxLines: maxLines,
            inputFormatters: inputFormatters,
          ),
        ],
      ),
    );
  }
}
