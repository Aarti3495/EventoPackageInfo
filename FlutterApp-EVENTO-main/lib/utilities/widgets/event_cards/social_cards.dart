// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:evento_package/utilities/index.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialCard extends StatelessWidget {
  SocialCard({Key? key, required this.icon, required this.link})
      : super(key: key);
  final String icon, link;

  final AppCss _appCss = AppCss();

  @override
  Widget build(BuildContext context) {
    List isImage = ['jpeg', 'jpg', 'png', 'gif'];
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
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
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 21,
                  child: isImage.contains(icon.split(".").last)
                      ? Image.asset(icon)
                      : SvgPicture.asset(icon),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    link,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _appCss.h4.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () async {
              Clipboard.setData(ClipboardData(text: link));
              commonHelper.bottomSnack("Link copied!", Colors.black87);
            },
            child: Text(
              "COPY",
              style: _appCss.sh4.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
