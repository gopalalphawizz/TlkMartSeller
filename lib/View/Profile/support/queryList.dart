import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/Profile/support/queryDetail.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/Placeholders/noSupport.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/dateFormatter.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class QueryListScreen extends StatefulWidget {
  const QueryListScreen({super.key});

  @override
  State<QueryListScreen> createState() => _QueryListScreenState();
}

class _QueryListScreenState extends State<QueryListScreen> {
  late ProfileViewModel profileP;

  @override
  void initState() {
    profileP = Provider.of<ProfileViewModel>(context, listen: false);
    profileP.getSupportQuerys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    profileP = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Customer Support"),
      body: profileP.isLoading
          ? appLoader()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: profileP.queries.isEmpty
                  ? Center(
                      child: NoTicketFound(
                          height: MediaQuery.of(context).size.height))
                  : ListView.builder(
                      itemCount: profileP.queries.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          PageTransition(
                              child: QueryDetailScreen(
                                  queryDetails: profileP.queries[index]),
                              type: PageTransitionType.rightToLeft),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: colors.lightGrey,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    profileP.queries[index].customerImage
                                        .toString(),
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            ErrorImageWidget(height: 60),
                                    height: 60,
                                    width: 60,
                                  ),
                                  VerticalDivider(color: Colors.transparent),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profileP.queries[index].subject
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        profileP.queries[index].customerEmail
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: colors.greyText),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date & Time",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: colors.greyText),
                                      ),
                                      Text(
                                        CustomDateFormat.formatDaate(profileP
                                            .queries[index].createdAt
                                            .toString()),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFFF9ECAC),
                                    ),
                                    child: Text(
                                      profileP.queries[index].status
                                          .toString()
                                          .toUpperCase(),
                                      style:
                                          TextStyle(color: Color(0xFFD89C01)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
    );
  }
}
