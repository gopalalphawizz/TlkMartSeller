import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/View/Dashboard/stockMgmt/updateStock.dart';
import 'package:alpha_work/ViewModel/productMgmtViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/Placeholders/NoProduct.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class StockManagementScreen extends StatefulWidget {
  const StockManagementScreen({super.key});

  @override
  State<StockManagementScreen> createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  late ProductManagementViewModel productP;
  getData() async {
    await productP.getProductsListWithStatus(
        Type: "all", stockType: "low_stock");
    await productP.getProductsListWithStatus(
        Type: "all", stockType: "out_of_stock");
  }

  @override
  void initState() {
    productP = Provider.of<ProductManagementViewModel>(context, listen: false);
    getData();
    super.initState();
  }

  int selectedTab = 1;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    productP = Provider.of<ProductManagementViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Stock Management"),
      body: productP.isLoading
          ? appLoader()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            selectedTab = 1;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: selectedTab == 1
                                    ? colors.buttonColor.withOpacity(0.3)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Low in Stock",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: selectedTab == 1
                                        ? colors.buttonColor
                                        : colors.greyText,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            selectedTab = 2;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: selectedTab == 1
                                    ? Colors.transparent
                                    : colors.buttonColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Out of Stock",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: selectedTab == 1
                                        ? colors.greyText
                                        : colors.buttonColor,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.transparent),
                  selectedTab == 1
                      ? Expanded(
                          child: Container(
                            child: productP.lowStock.isEmpty
                                ? NoProductPlaceholder(
                                    height: height, width: width)
                                : ListView.builder(
                                    itemCount: productP.lowStock.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () => Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: UpdateStockScreen(
                                                      Pdata: productP
                                                          .lowStock[index]),
                                                  type: PageTransitionType
                                                      .rightToLeft))
                                          .then((value) =>
                                              value ? initState() : null),
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightGrey),
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: productP
                                                              .lowStock[index]
                                                              .currentStock <
                                                          productP
                                                              .lowStock[index]
                                                              .minimumOrderQty
                                                      ? Colors.red
                                                      : Colors.amber,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: height * .1,
                                                      width: height * .1,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                          productP
                                                              .lowStock[index]
                                                              .thumbnail
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  url, error) =>
                                                              ErrorImageWidget(
                                                                  height: null),
                                                        ),
                                                      ),
                                                    ),
                                                    VerticalDivider(
                                                        color:
                                                            Colors.transparent,
                                                        width: 12),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        SizedBox(
                                                          width: width * .55,
                                                          child: AutoSizeText(
                                                            productP
                                                                .lowStock[index]
                                                                .name
                                                                .toString(),
                                                            maxLines: 2,
                                                            maxFontSize: 18,
                                                            minFontSize: 16,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(
                                                            color: Colors
                                                                .transparent,
                                                            height: 4),
                                                        SizedBox(
                                                          width: width * .55,
                                                          child:
                                                              AutoSizeText.rich(
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            TextSpan(children: [
                                                              TextSpan(
                                                                  text:
                                                                      "SKU ID-",
                                                                  style:
                                                                      TextStyle(
                                                                    color: colors
                                                                        .greyText,
                                                                  )),
                                                              TextSpan(
                                                                  text: " "),
                                                              TextSpan(
                                                                  text: productP
                                                                      .lowStock[
                                                                          index]
                                                                      .slug
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  )),
                                                            ]),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                    color: Colors.transparent,
                                                    height: 7),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Current Stock Level",
                                                          style: TextStyle(
                                                              color: colors
                                                                  .greyText),
                                                        ),
                                                        Text(
                                                            productP
                                                                .lowStock[index]
                                                                .currentStock
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge),
                                                      ],
                                                    ),
                                                    VerticalDivider(),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Reorder Point",
                                                          style: TextStyle(
                                                              color: colors
                                                                  .greyText),
                                                        ),
                                                        Text(
                                                          productP
                                                              .lowStock[index]
                                                              .minimumOrderQty
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      : Expanded(
                          child: productP.outOfStock.isEmpty
                              ? NoProductPlaceholder(
                                  height: height, width: width)
                              : Container(
                                  child: ListView.builder(
                                    itemCount: productP.outOfStock.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () => Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: UpdateStockScreen(
                                                      Pdata: productP
                                                          .lowStock[index]),
                                                  type: PageTransitionType
                                                      .rightToLeft))
                                          .then((value) =>
                                              value ? initState() : null),
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colors.lightGrey),
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: height * .1,
                                                  width: height * .1,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      productP.outOfStock[index]
                                                          .thumbnail
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                              url, error) =>
                                                          ErrorImageWidget(
                                                              height: null),
                                                    ),
                                                  ),
                                                ),
                                                VerticalDivider(
                                                    color: Colors.transparent,
                                                    width: 12),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SizedBox(
                                                      width: width * .55,
                                                      child: AutoSizeText(
                                                        productP
                                                            .outOfStock[index]
                                                            .name
                                                            .toString(),
                                                        maxLines: 2,
                                                        maxFontSize: 18,
                                                        minFontSize: 16,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Divider(
                                                        color:
                                                            Colors.transparent,
                                                        height: 4),
                                                    SizedBox(
                                                      width: width * .55,
                                                      child: AutoSizeText.rich(
                                                        maxLines: 1,
                                                        maxFontSize: 14,
                                                        minFontSize: 12,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        TextSpan(children: [
                                                          TextSpan(
                                                              text: "SKU ID-",
                                                              style: TextStyle(
                                                                color: colors
                                                                    .greyText,
                                                              )),
                                                          TextSpan(text: " "),
                                                          TextSpan(
                                                              text: productP
                                                                  .outOfStock[
                                                                      index]
                                                                  .slug
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              )),
                                                        ]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                ],
              ),
            ),
    );
  }
}
