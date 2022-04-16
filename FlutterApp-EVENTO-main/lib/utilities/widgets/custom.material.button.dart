import 'package:evento_package/utilities/screen.util.dart';
import 'package:evento_package/utilities/themes/app.colors.dart';
import 'package:evento_package/utilities/themes/app.css.dart';
import 'package:flutter/material.dart';

AppScreen appScreenUtil = new AppScreen();
AppColors appColor = new AppColors();
AppCss appCss = new AppCss();

class CustomMaterialButton extends StatelessWidget {
  final String title;
  final dynamic padding;
  final dynamic radius;
  final Function onTap;
  final TextStyle? style;
  final Color? color;
  final Color? iconColor;
  final dynamic iconSize;
  final IconData? icon;
  final dynamic width;
  final Border? border;

  const CustomMaterialButton({
    Key? key,
    required this.title,
    this.padding = 10,
    this.radius = 10,
    required this.onTap,
    this.style,
    this.color,
    this.icon,
    this.iconColor,
    this.iconSize = 25,
    this.width,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(appScreenUtil.borderRadius(radius)),
      child: Container(
        color: color ?? Theme.of(context).primaryColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onTap(),
            child: Container(
              padding: EdgeInsets.all(appScreenUtil.screenWidth(padding)),
              width: width != null
                  ? appScreenUtil.screenWidth(width)
                  : MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: border,
                borderRadius:
                    BorderRadius.circular(appScreenUtil.borderRadius(radius)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Row(
                      children: [
                        Icon(icon,
                            color: iconColor,
                            size: appScreenUtil.screenWidth(iconSize)),
                        SizedBox(width: appScreenUtil.screenWidth(10)),
                      ],
                    ),
                  Text(
                    title,
                    style: style ?? appCss.h4,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
