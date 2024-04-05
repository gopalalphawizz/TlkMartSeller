import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/ORDER/pickupBottamsheet.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/comman_header.dart';
import 'package:flutter/material.dart';

class PickupDetailScreen extends StatefulWidget {
  const PickupDetailScreen({super.key});

  @override
  State<PickupDetailScreen> createState() => _PickupDetailScreenState();
}

class _PickupDetailScreenState extends State<PickupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.transparent
                : colors.buttonColor,
            child: const Stack(
              children: [
                ProfileHeader(),
                InternalDetailPageHeader(
                  text: "Pickup Details",
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.transparent,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: (height / width) * 20,
                  backgroundColor: colors.boxBorder,
                  backgroundImage: AssetImage(Images.driver_profile),
                ),
                VerticalDivider(color: Colors.transparent),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Jane Cooper",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 5,
                    ),
                    Text(
                      "Min-weight: 0.5kg",
                      style: TextStyle(
                        fontSize: 16,
                        color: colors.greyText,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expected Pickup",
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.greyText,
                      ),
                    ),
                    Text(
                      "Tomorrow",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Estimated Delivery",
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.greyText,
                      ),
                    ),
                    Text(
                      "4 Nov 2023",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chargeable Weight",
                  style: TextStyle(
                    fontSize: 18,
                    color: colors.greyText,
                  ),
                ),
                Text(
                  "0.5 kg",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Price Detail",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "MRP (1 item)",
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? colors.textColor
                                    : Colors.black,
                            fontSize: 12),
                      ),
                      Text(
                        "\$ 120.0",
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? colors.textColor
                                    : Colors.black,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Alpha Delivery Charges",
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? colors.greyText
                                    : Colors.black54,
                            fontSize: 12),
                      ),
                      Text(
                        "\$ 10",
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? colors.textColor
                                    : Colors.black,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount",
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? colors.greyText
                                    : Colors.black54,
                            fontSize: 12),
                      ),
                      Text(
                        "\$ 80",
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? colors.textColor
                                    : Colors.black,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 5,
                  color: colors.greyText,
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? colors.textColor
                                    : Colors.black,
                            fontSize: 14),
                      ),
                      Text(
                        "\$ 120.0",
                        style:
                            TextStyle(color: colors.buttonColor, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 5,
                  color: colors.greyText,
                  thickness: 1,
                ),
              ],
            ),
          ),
          Spacer(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          //   child: ElevatedButton(
          //     onPressed: () => showBottomSheet(
          //       context: context,
          //       builder: (context) => PickupBottomSheet(orderId: ""),
          //     ),
          //     child: Text("SHIP NOW", style: TextStyle(color: Colors.white)),
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: colors.buttonColor,
          //         padding: const EdgeInsets.all(12),
          //         minimumSize: Size(width, 45),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //         )),
          //   ),
          // )
        ],
      ),
    );
  }
}
