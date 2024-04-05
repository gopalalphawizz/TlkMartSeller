import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:flutter/material.dart';

class NoNotification extends StatelessWidget {
  const NoNotification({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(Images.notification,
              height: height * .32, width: width, fit: BoxFit.contain),
        ),
        Text(
          "No Notifications Found",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: colors.greyText,
          ),
        ),
      ],
    );
  }
}
