import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:flutter/material.dart';

class NoSearch extends StatelessWidget {
  const NoSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(Images.emptySearch,
              height: 100, width: 100, fit: BoxFit.contain),
        ),
        Text(
          "Nothing Found",
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
