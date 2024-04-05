import 'package:flutter/material.dart';

import '../../../../Widget/CommonTextFromWidget/commontextform.dart';
import '../../../../Widget/CommonTextWidget/commontext.dart';

class BnkingPage extends StatefulWidget {
  const BnkingPage({super.key});

  @override
  State<BnkingPage> createState() => _BnkingPageState();
}

class _BnkingPageState extends State<BnkingPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController banknamecontroller = TextEditingController();
    TextEditingController bankbranchcontroller = TextEditingController();
    TextEditingController accounttypecontroller = TextEditingController();
    TextEditingController micrController = TextEditingController();
    TextEditingController bankaddresscontroler = TextEditingController();
    TextEditingController accountcontroller = TextEditingController();
    TextEditingController ifsccontroller = TextEditingController();
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SignupHeadingText(
              text: 'Enter Your banking Information',
            ),
            // const Text("abc"),
            // const SizedBox(
            //   height: 50,
            // ),
            // CommonTextForm(
            //   controllername: banknamecontroller,
            //   labelname: 'Bank Name*',
            // ),
            // const SizedBox(
            //   height: 6,
            // ),
            // CommonTextForm(
            //   controllername: bankbranchcontroller,
            //   labelname: 'Bank Branch*',
            // ),
            // const SizedBox(
            //   height: 6,
            // ),
            // CommonTextForm(
            //   controllername: accounttypecontroller,
            //   labelname: 'Account Type*',
            // ),
            // const SizedBox(
            //   height: 6,
            // ),
            // CommonTextForm(
            //   controllername: micrController,
            //   labelname: 'MICR code*',
            // ),
            // const SizedBox(
            //   height: 6,
            // ),
            // CommonTextForm(
            //   controllername: bankaddresscontroler,
            //   labelname: 'Bank Address*',
            // ),
            // const SizedBox(
            //   height: 6,
            // ),
            // CommonTextForm(
            //   controllername: accountcontroller,
            //   labelname: 'Account Number*',
            // ),
            // const SizedBox(
            //   height: 6,
            // ),
            // CommonTextForm(
            //   controllername: ifsccontroller,
            //   labelname: 'IFSC Code*',
            // ),
            // const SizedBox(
            //   height: 6,
            // ),
          ],
        ),
      ),
    );
  }
}
