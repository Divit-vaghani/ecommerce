import 'package:ecommerce/const/const.dart';
import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(
    this.name, {
    Key? key,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 17,
    this.color = AppColor.textColor,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final String name;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
