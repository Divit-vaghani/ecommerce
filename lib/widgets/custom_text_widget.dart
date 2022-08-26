import 'package:ecommerce/const/const.dart';
import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(this.name,
      {Key? key, this.fontWeight = FontWeight.w500, this.fontSize = 17})
      : super(key: key);

  final String name;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: AppColor.textColor,
      ),
    );
  }
}
