import 'package:alpha_work/Utils/images.dart';
import 'package:flutter/material.dart';

class ErrorImageWidget extends StatelessWidget {
  final double? height;

  const ErrorImageWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Images.error_image,
      fit: BoxFit.contain,
      height: height,
    );
  }
}
