import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:flutter/material.dart';

class NoTicketFound extends StatelessWidget {
  const NoTicketFound({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(Images.NoTicket, fit: BoxFit.fitWidth),
        ),
        Text(
          "No Queries Found",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: colors.buttonColor,
          ),
        )
      ],
    );
  }
}
