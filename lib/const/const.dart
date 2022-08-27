import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(output: ConsoleOutput());

class AppColor {
  static const Color iconColor = Color(0xff7D7D7D);
  static const Color textColor = Color(0xff7D7D7D);
}

class Assets {
  static const String error = "assets/lottie/error.json";
}

class WebApiUtility {
  static const String url =
      "http://205.134.254.135/~mobile/MtProject/public/api/product_list.php";
  static const String token =
      "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz";
}
