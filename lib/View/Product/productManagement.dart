import 'package:alpha_work/Model/productManagementModel.dart';
import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/Product/categoryProductList.dart';
import 'package:alpha_work/View/Product/productStatusList.dart';
import 'package:alpha_work/View/Product/addProduct.dart';
import 'package:alpha_work/ViewModel/productMgmtViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  int slectedIndex = 0;
  late ProductManagementViewModel productMgmtProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productMgmtProvider =
        Provider.of<ProductManagementViewModel>(context, listen: false);
    productMgmtProvider.getProductManagement();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    productMgmtProvider = Provider.of<ProductManagementViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Product Management"),
      body: productMgmtProvider.isLoading
          ? appLoader()
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    color: colors.lightGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                child: ActiveProductScreen(
                                  appBartitle: "All Products",
                                  type: 'all',
                                ),
                                type: PageTransitionType.rightToLeft),
                          ).then((value) =>
                              productMgmtProvider.getProductManagement()),
                          child: Container(
                            width: width / 3.33,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "Total Product",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: colors.greyText,
                                  ),
                                ),
                                Text(
                                  productMgmtProvider
                                      .productManagementData.totalProduct
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                child: ActiveProductScreen(
                                  appBartitle: "Active Products",
                                  type: '1',
                                ),
                                type: PageTransitionType.rightToLeft),
                          ).then((value) =>
                              productMgmtProvider.getProductManagement()),
                          child: Container(
                            width: width / 3.33,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Active",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.greyText,
                                  ),
                                ),
                                Text(
                                  productMgmtProvider
                                      .productManagementData.activeProduct
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                child: ActiveProductScreen(
                                  appBartitle: "Inactive Products",
                                  type: '0',
                                ),
                                type: PageTransitionType.rightToLeft),
                          ).then((value) =>
                              productMgmtProvider.getProductManagement()),
                          child: Container(
                            width: width / 3.33,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Inactive",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.greyText,
                                  ),
                                ),
                                Text(
                                  productMgmtProvider
                                      .productManagementData.inactiveProduct
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  productMgmtProvider.productManagementData.categories.length !=
                          0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: SizedBox(
                            width: width,
                            height: 30,
                            child: ListView.builder(
                              itemCount: productMgmtProvider
                                  .productManagementData.categories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () => setState(() {
                                  slectedIndex = index;
                                }),
                                child: Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: slectedIndex == index
                                        ? Color(0xFFD5F6F6)
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    productMgmtProvider.productManagementData
                                        .categories[index].name
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: slectedIndex == index
                                          ? colors.buttonColor
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  productMgmtProvider.productManagementData.categories.length !=
                          0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: SizedBox(
                            height: height * .6,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: productMgmtProvider
                                  .productManagementData
                                  .categories[slectedIndex]
                                  .childes
                                  .length,
                              itemBuilder: (context, indx) => GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    PageTransition(
                                        child: categoryProductScreen(
                                            appBartitle: productMgmtProvider
                                                .productManagementData
                                                .categories[slectedIndex]
                                                .childes[indx]
                                                .name
                                                .toString(),
                                            subCatID: productMgmtProvider
                                                .productManagementData
                                                .categories[slectedIndex]
                                                .childes[indx]
                                                .id
                                                .toString(),
                                            catId: productMgmtProvider
                                                .productManagementData
                                                .categories[slectedIndex]
                                                .id
                                                .toString(),
                                            type: 'all'),
                                        type: PageTransitionType.rightToLeft)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: productMgmtProvider
                                          .productManagementData
                                          .categories[slectedIndex]
                                          .childes[indx]
                                          .icon
                                          .toString(),
                                      height: height * .1,
                                      fit: BoxFit.fitHeight,
                                      errorWidget: (context, error,
                                              stackTrace) =>
                                          ErrorImageWidget(height: height * .1),
                                    ),
                                    Text(
                                      productMgmtProvider
                                          .productManagementData
                                          .categories[slectedIndex]
                                          .childes[indx]
                                          .name
                                          .toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            PageTransition(
                child: AddProdutScreen(isFromHome: false),
                type: PageTransitionType.rightToLeft)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: colors.buttonColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
