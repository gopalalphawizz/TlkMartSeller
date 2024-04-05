import 'dart:ffi';

import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Utils/shared_pref..dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/Placeholders/NoRefer.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  String refCode = "";
  late ProfileViewModel proProvider;
  String formatDaate(String dateString) {
    // Parse the date string
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  void initState() {
    proProvider = Provider.of<ProfileViewModel>(context, listen: false);
    proProvider.getReferralData();
    refCode = proProvider.vendorData.shop!.refferral.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    proProvider = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Refer and Earn"),
      body: proProvider.isLoading
          ? appLoader()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? colors.boxBorder
                        : const Color(0xFFCEEAEA).withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            Images.refer,
                            height: 100,
                            width: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Images.refer_coin,
                                height: 28,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "2562",
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Text(
                            "Referral Points",
                            style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                height: 1.5),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: DottedBorder(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : const Color(0xFF0A9494),
                                strokeWidth: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xA6064848)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius as needed
                                    // border: Border.all(
                                    //   color: Colors.white,
                                    //   width: 1, // Border width
                                    // ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Text(
                                              "Your referral code",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : colors.greyText,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              // user.data[0].referralCode,
                                              refCode,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 35,
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await Clipboard.setData(
                                                ClipboardData(text: refCode));
                                            Utils.showTost(
                                                msg: "Referral Code Copied.");
                                          },
                                          child: Text(
                                            "Copy\nCode",
                                            style: TextStyle(
                                              fontSize: 12,
                                              height: 1.5,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // share(context, user.data[0].referralCode);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.ios_share_outlined,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Share Code",
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      "Referall Members",
                      style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                    child: proProvider.referrals.isEmpty
                        ? NoReferPlaceholder(
                            height: MediaQuery.of(context).size.height * .5,
                            width: MediaQuery.of(context).size.width)
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: proProvider.referrals.length,
                            separatorBuilder: (context, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 20),
                              color: Colors.grey.withOpacity(0.7),
                              height: .5,
                            ),
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width:
                                                  40, // Set the width and height to create a circular shape
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape
                                                    .circle, // Make the container circular
                                                color: Color(
                                                    0x6B969696), // Set the background color
                                              ),
                                              child: Center(
                                                child: Text(
                                                  proProvider
                                                      .referrals[i].name![0]
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : Colors
                                                            .black, // Set the text color
                                                    fontSize:
                                                        14, // Set the text size
                                                    fontWeight: FontWeight
                                                        .bold, // Set the text weight
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  proProvider.referrals[i].name
                                                      .toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    formatDaate(proProvider
                                                        .referrals[i].createdAt
                                                        .toString()),
                                                    style: TextStyle(
                                                        color: colors
                                                            .lightTextColor,
                                                        fontSize: 12))
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Text(
                                        //   // profileProvider.referralList[i].balance
                                        //   //     .toString(),
                                        //   "200",
                                        //   style: TextStyle(
                                        //       color: Theme.of(context).brightness ==
                                        //               Brightness.dark
                                        //           ? Colors.white
                                        //           : Colors.black,
                                        //       fontSize: 14,
                                        //       fontWeight: FontWeight.bold),
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
