import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:flutter/material.dart';

class NoCustomerPlaceholder extends StatelessWidget {
  const NoCustomerPlaceholder({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(Images.noCustomer,
                height: height * .25, width: width * .75, fit: BoxFit.contain),
          ),
          Text(
            "No Customer Data Found",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: colors.greyText,
            ),
          ),
        ],
      ),
    );
  }
}
