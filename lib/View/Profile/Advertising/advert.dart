import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:flutter/material.dart';

class AdvertScreen extends StatelessWidget {
  const AdvertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommanAppbar(appbarTitle: "Advertainment Request"),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Images.happy),
          fit: BoxFit.fitWidth,
        )),
      ),
    );
  }
}
