import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Widget/Placeholders/NoProduct.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:alpha_work/View/Product/productDetail.dart';
import 'package:alpha_work/ViewModel/productMgmtViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:searchable_listview/searchable_listview.dart';

class categoryProductScreen extends StatefulWidget {
  final String appBartitle;
  final String type;
  final String catId;
  final String subCatID;

  const categoryProductScreen(
      {super.key,
      required this.appBartitle,
      required this.type,
      required this.catId,
      required this.subCatID});

  @override
  State<categoryProductScreen> createState() => _categoryProductScreenState();
}

class _categoryProductScreenState extends State<categoryProductScreen> {
  late ProductManagementViewModel productstatusP;
  @override
  void initState() {
    productstatusP =
        Provider.of<ProductManagementViewModel>(context, listen: false);
    print("id's- ${widget.catId}, ${widget.subCatID}");
    productstatusP.getProductsListWithCategory(
        Type: widget.type, catId: widget.catId, subcatId: widget.subCatID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    productstatusP = Provider.of<ProductManagementViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: widget.appBartitle),
      body: productstatusP.isLoading
          ? appLoader()
          : productstatusP.productList.isEmpty
              ? NoProductPlaceholder(height: height, width: width)
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SearchableList(
                    autoFocusOnSearch: false,
                    inputDecoration: (const InputDecoration())
                        .applyDefaults(Theme.of(context).inputDecorationTheme)
                        .copyWith(
                          hintText: "Search by Product Name",
                          hintStyle: TextStyle(
                              color: colors.greyText,
                              fontWeight: FontWeight.normal),
                        ),
                    filter: (value) => productstatusP.productList
                        .where(
                          (element) => element.name!
                              .toString()
                              .toLowerCase()
                              .contains(value),
                        )
                        .toList(),
                    emptyWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(Images.emptySearch,
                              height: height * .25,
                              width: width,
                              fit: BoxFit.contain),
                        ),
                        Text(
                          "No Data Found",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: colors.greyText,
                          ),
                        ),
                      ],
                    ),
                    initialList: productstatusP.productList,
                    builder: (displayedList, index, item) => GestureDetector(
                      onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                  child: ProductDetailScreen(
                                      id: item.id.toString()),
                                  type: PageTransitionType.rightToLeft))
                          .then((value) => initState()),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: height * .1,
                              width: height * .1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item.thumbnail.toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, url, error) =>
                                      ErrorImageWidget(height: null),
                                ),
                              ),
                            ),
                            VerticalDivider(
                                color: Colors.transparent, width: 7),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: width * .5,
                                  child: AutoSizeText(
                                    item.name.toString(),
                                    maxLines: 1,
                                    maxFontSize: 16,
                                    minFontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * .4,
                                  child: RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "SKU ID-",
                                          style: TextStyle(
                                            color: colors.greyText,
                                            fontSize: 14,
                                          )),
                                      TextSpan(text: " "),
                                      TextSpan(
                                          text: item.slug.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          )),
                                    ]),
                                  ),
                                ),
                                AutoSizeText.rich(
                                  maxFontSize: 16,
                                  minFontSize: 14,
                                  style: TextStyle(fontFamily: 'Montreal'),
                                  TextSpan(children: [
                                    TextSpan(
                                        text: productstatusP
                                            .productList[index].specialPrice
                                            .toString(),
                                        style: TextStyle(
                                          color: colors.buttonColor,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    TextSpan(text: ' '),
                                    TextSpan(
                                        text: productstatusP
                                            .productList[index].unitPrice
                                            .toString(),
                                        style: TextStyle(
                                          color: colors.greyText,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        )),
                                  ]),
                                ),
                              ],
                            ),
                            widget.appBartitle == "All Products"
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: item.status == 1
                                            ? Colors.green.withOpacity(0.3)
                                            : Colors.red.withOpacity(0.3)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    child: Text(
                                      item.status == 1 ? "Active" : "Inactive",
                                      style: TextStyle(
                                          color: item.status == 1
                                              ? Colors.green
                                              : Colors.redAccent),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
