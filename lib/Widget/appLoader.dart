import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Utils/color.dart';

appLoader() {
  return Center(
    child: LoadingAnimationWidget.halfTriangleDot(
      color: colors.buttonColor,
      size: 40,
    ),
  );
}
