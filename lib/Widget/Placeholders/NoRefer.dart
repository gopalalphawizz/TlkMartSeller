import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:flutter/material.dart';

class NoReferPlaceholder extends StatelessWidget {
  const NoReferPlaceholder({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(Images.noRefer,
              height: height * .32, width: width, fit: BoxFit.contain),
        ),
        Text(
          "No Refers Yet",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: colors.greyText,
          ),
        ),
      ],
    );
  }
}
