import 'dart:io';

import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/comman_header.dart';
import 'package:flutter/material.dart';

class CommanAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String appbarTitle;

  const CommanAppbar({super.key, required this.appbarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            // Routes.navigateToPreviousScreen(context);
            Navigator.pop(context, false);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25,
            color: Colors.white,
          ),
        ),
        title: Text(
          appbarTitle,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.transparent
                : colors.buttonColor,
            image: DecorationImage(
              alignment: Alignment.centerRight,
              image: AssetImage(Images.headerBGLine),
              fit: BoxFit.contain,
            ),
            // child: Stack(
            //   children: [
            //     ProfileHeader(),
            //     InternalDetailPageHeader(
            //       text: appbarTitle,
            //     ),
            //   ],
            // ),
          ),
        ));
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }
}
