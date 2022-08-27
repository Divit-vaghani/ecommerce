import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingErrorWidget extends StatelessWidget {
  const LoadingErrorWidget({Key? key, required this.error}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        error,
        height: 150,
        animate: false,
        frameRate: FrameRate.max,
      ),
    );
  }
}
