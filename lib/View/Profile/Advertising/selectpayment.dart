import 'dart:io';

import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/Dashboard/Dashboad.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SelectPaymentScreen extends StatefulWidget {
  final String amount;
  final String adId;
  final String heading;
  final File image;
  final List<String> productIds;
  final String StartingDate;

  SelectPaymentScreen(
      {super.key,
      required this.amount,
      required this.adId,
      required this.heading,
      required this.image,
      required this.StartingDate,
      required this.productIds});

  @override
  State<SelectPaymentScreen> createState() => _SelectPaymentScreenState();
}

class _SelectPaymentScreenState extends State<SelectPaymentScreen> {
  bool Selected = true;
  Razorpay? _razorpay;
  int? pricerazorpayy;
  late ProfileViewModel provider;
  String? transactionId;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    provider = Provider.of<ProfileViewModel>(context, listen: false);
    print(widget.productIds);
  }

  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy = int.parse(res.toStringAsFixed(0)) * 100;
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "$pricerazorpayy",
      'name': 'Advertising',
      'image': 'assets/images/alpha_logo-light.png',
      'description': 'Advertising',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future<void> _handlePaymentSuccess(
    PaymentSuccessResponse response,
  ) async {
    print("transaction id${response.paymentId!}");
    transactionId = response.paymentId.toString();
    Utils.showTost(msg: "Payment successfull.");
    await provider.UploadBanner(
            adId: widget.adId,
            amount: widget.amount,
            path: widget.image.path,
            productIds: widget.productIds,
            startDate: widget.StartingDate,
            transaction_id: response.paymentId.toString())
        .then((value) => value
            ? showDialog(
                context: context,
                builder: (ctx) {
                  Future.delayed(Duration(seconds: 3)).then((value) {
                    Navigator.pop(ctx);
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                            child: DashboardScreen1(),
                            type: PageTransitionType.rightToLeft),
                        (route) => false);
                  });
                  return AdSuccessDialog();
                },
              )
            : null);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Utils.showTost(msg: "Payment cancelled by user");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Payment Method"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Payment Method",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const Divider(color: Colors.transparent),
            Container(
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors.lightGrey,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.heading,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.amount,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.transparent),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: colors.lightGrey,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/razorpay.png",
                    height: 50,
                  ),
                  const VerticalDivider(
                    color: Colors.transparent,
                    width: 5,
                  ),
                  Text(
                    "Razor pay",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Radio(
                    value: Selected,
                    groupValue: true,
                    activeColor: colors.buttonColor,
                    onChanged: (value) => {},
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.transparent),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () {
            openCheckout(widget.amount);
          },
          style: ElevatedButton.styleFrom(fixedSize: Size(width * .9, 50)),
          child: Text(
            "CONTINUE",
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}

class AdSuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: colors.buttonColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Image(
                height: 100, width: 150, image: AssetImage(Images.tickSquare)),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "Thank You for Advertising",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: colors.lightTextColor,
                  fontSize: Platform.isAndroid ? 14 : 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: colors.lightTextColor,
                  fontSize: Platform.isAndroid ? 14 : 16),
            ),
          )
        ],
      ),
    );
  }
}
