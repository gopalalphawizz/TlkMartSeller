import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/Customer/customerDetail.dart';
import 'package:alpha_work/ViewModel/customerViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/Placeholders/NoCustomer.dart';
import 'package:alpha_work/Widget/Placeholders/NoSearch.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:searchable_listview/searchable_listview.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late CustomerViewModel provider;
  @override
  void initState() {
    provider = Provider.of<CustomerViewModel>(context, listen: false);
    provider.getCustomerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    provider = Provider.of<CustomerViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Customers"),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: provider.isLoading
            ? appLoader()
            : provider.customers.isEmpty
                ? Center(
                    child: NoCustomerPlaceholder(height: height, width: width),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: SearchableList(
                            initialList: provider.customers,
                            inputDecoration: (const InputDecoration())
                                .applyDefaults(
                                    Theme.of(context).inputDecorationTheme)
                                .copyWith(
                                  hintText: "Search by Name",
                                  hintStyle: TextStyle(
                                      color: colors.greyText,
                                      fontWeight: FontWeight.normal),
                                ),
                            autoFocusOnSearch: false,
                            emptyWidget: NoSearch(),
                            filter: (query) => provider.customers
                                .where((ele) => ele.fName
                                    .toString()
                                    .toLowerCase()
                                    .contains(query))
                                .toList(),
                            builder: (displayedList, index, item) =>
                                GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  PageTransition(
                                      child: CustomerDetailScreen(data: item),
                                      type: PageTransitionType.rightToLeft)),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    color: colors.lightGrey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: height * .06,
                                          width: height * .06,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              item.image.toString(),
                                              fit: BoxFit.fill,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  ErrorImageWidget(
                                                      height: height),
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: width * .65,
                                              child: Text(
                                                item.fName.toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              item.phone.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: colors.greyText,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Divider(
                                        height: 5, color: Colors.transparent),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Email",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: colors.greyText,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          item.email.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
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
                    ],
                  ),
      ),
    );
  }
}
