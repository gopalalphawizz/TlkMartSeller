import 'package:alpha_work/View/ORDER/pickupDetail.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../View/ORDER/ordermanagement.dart';

class NavigateToRouter {
  // navigatetonextScreen(BuildContext context) {
  //   Navigator.push(
  //       context,
  //       PageTransition(
  //           type: PageTransitionType.rightToLeft,
  //           child: const OrderManagement()));
  // }

  navigatetoPickupDetailScreen(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const PickupDetailScreen()));
  }
}
