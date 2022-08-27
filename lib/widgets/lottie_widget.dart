import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        path,
        height: 150,
        animate: false,
        frameRate: FrameRate.max,
      ),
    );
  }
}
