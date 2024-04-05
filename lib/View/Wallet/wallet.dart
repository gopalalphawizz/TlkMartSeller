import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/ViewModel/walletViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final TextEditingController amountCtrl = TextEditingController();
  late WalletViewMaodel provider;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String? withAmt;
  @override
  void initState() {
    provider = Provider.of<WalletViewMaodel>(context, listen: false);
    getData();
    super.initState();
  }

  getColor<Color>(int status) {
    switch (status) {
      case 0:
        return Colors.purple;
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      default:
        Colors.purple;
    }
  }

  getStatus<Color>(int status) {
    switch (status) {
      case 0:
        return "Pending";
      case 1:
        return "Accepted";
      case 2:
        return "Declined";
      default:
        "Pending";
    }
  }

  getData() async {
    await provider.transactionList();
    withAmt = provider.transaction!.withdrawalAmount
        .toString()
        .replaceAll(RegExp('[^A-Za-z0-9.]'), '');
    print("Withdraw amount: $withAmt");
  }

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    provider = Provider.of<WalletViewMaodel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Wallet"),
      body: provider.isLoading
          ? appLoader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: height * .34,
                  padding: const EdgeInsets.all(16),
                  color: colors.buttonColor.withOpacity(0.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.walletImage,
                        height: height * .13,
                        fit: BoxFit.fitHeight,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Image.asset(
                            Images.walletMoney,
                            width: width * .08,
                          ),
                          VerticalDivider(width: 5),
                          Text(
                            provider.transaction!.withdrawalAmount.toString(),
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontFamily: 'Montreal',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Text(
                        "Current Balance",
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.greyText,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Divider(color: Colors.transparent, height: 5),
                      ElevatedButton(
                          onPressed: () => showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                )),
                                context: context,
                                builder: (ctx) => Container(
                                  height: height * .37,
                                  width: width,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Withdraw Request",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Send a request to the admin to \nwithdraw the money",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: colors.greyText,
                                        ),
                                      ),
                                      Spacer(),
                                      Form(
                                        key: _key,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: amountCtrl,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: InputDecoration()
                                              .applyDefaults(Theme.of(context)
                                                  .inputDecorationTheme)
                                              .copyWith(
                                                  hintText: "Enter Amount",
                                                  hintStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter amount";
                                            } else if (double.parse(amountCtrl
                                                    .text
                                                    .toString()) <=
                                                0) {
                                              return "Enter a valid amount";
                                            } else if (double.parse(
                                                    amountCtrl.text) >
                                                double.parse(
                                                    withAmt.toString())) {
                                              return "Withdraw amount can't be greater than balance";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      Spacer(),
                                      ElevatedButton(
                                          onPressed: () async {
                                            if (_key.currentState!.validate()) {
                                              provider
                                                  .withdrawMoney(
                                                      amount: amountCtrl.text
                                                          .toString())
                                                  .then((value) async {
                                                Fluttertoast.showToast(
                                                  msg: value,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      colors.buttonColor,
                                                  textColor: Colors.white,
                                                );
                                                await getData();
                                                Navigator.pop(ctx);
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size(width, 45)),
                                          child: Text(
                                            "Withdraw",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Text(
                            "Request for Withdraw",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "History",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const Divider(color: Colors.transparent),
                      SizedBox(
                        height: height * .44,
                        child: provider.transaction!.data.length == 0
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox.square(
                                      dimension: height * .2,
                                      child: Image.asset(
                                        Images.noTransaction,
                                      ),
                                    ),
                                    Text(
                                      "No transaction ",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "You haven’t made any transactions yet",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: colors.greyText,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                  color: colors.lightGrey,
                                  thickness: 2,
                                ),
                                shrinkWrap: true,
                                itemCount: provider.transaction!.data.length,
                                itemBuilder: (context, index) => Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider
                                              .transaction!.data[index].amount
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Montreal',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: width * .7,
                                          child: Text(
                                            provider.transaction!.data[index]
                                                    .transactionNote
                                                    .toString()
                                                    .isEmpty
                                                ? "Transaction under approval"
                                                : provider.transaction!
                                                    .data[index].transactionNote
                                                    .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatter.format(DateTime.parse(
                                              provider.transaction!.data[index]
                                                  .createdAt
                                                  .toString())),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Divider(
                                            color: Colors.transparent,
                                            height: 3),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 5),
                                          decoration: BoxDecoration(
                                              color: getColor(int.parse(provider
                                                      .transaction!
                                                      .data[index]
                                                      .approved
                                                      .toString()))
                                                  .withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            getStatus(int.parse(provider
                                                .transaction!
                                                .data[index]
                                                .approved
                                                .toString())),
                                            style: TextStyle(
                                              color: getColor(int.parse(provider
                                                  .transaction!
                                                  .data[index]
                                                  .approved
                                                  .toString())),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
