import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:flutter/material.dart';

class BasicCard extends StatelessWidget {
  BasicCard({
    Key? key,
    required this.leadingText,
    required this.trailingText,
    required this.leadingColor,
    required this.trailingColor,
    this.bottomMargin = 0.0,
  }) : super(key: key);

  final String leadingText, trailingText;
  final int leadingColor, trailingColor;
  final double bottomMargin;
  final AppCss _appCss = AppCss();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 4,
            color: Color.fromRGBO(0, 0, 0, 0.16),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leadingText,
            style: _appCss.sh4.copyWith(
              color: leadingColor == 0 ? Colors.blueGrey : Color(leadingColor),
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            trailingText,
            style: _appCss.sh4.copyWith(
              color: trailingColor == 0 ? Colors.black : Color(trailingColor),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
