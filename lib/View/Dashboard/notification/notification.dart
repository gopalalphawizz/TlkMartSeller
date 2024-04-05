import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/View/ORDER/ordermanagement.dart';
import 'package:alpha_work/ViewModel/dashboardViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/Placeholders/NoNotification.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/dateFormatter.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late DashboardViewModel notiPro;
  @override
  void initState() {
    notiPro = Provider.of<DashboardViewModel>(context, listen: false);
    notiPro.getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    notiPro = Provider.of<DashboardViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Notifications"),
      body: notiPro.isLoading
          ? appLoader()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: notiPro.notifications.isEmpty
                  ? NoNotification(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity)
                  : ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: colors.lightGrey,
                      ),
                      itemCount: notiPro.notifications.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => notiPro.notifications[index].title!
                                .contains("order received")
                            ? Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: OrderManagement(index: 0),
                                    type: PageTransitionType.rightToLeft),
                              )
                            : null,
                        child: ListTile(
                          dense: true,
                          leading: Container(
                            height: MediaQuery.of(context).size.height * .07,
                            width: MediaQuery.of(context).size.height * .07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colors.white10,
                              image: DecorationImage(
                                image: AssetImage(Images.error_image),
                                onError: (exception, stackTrace) =>
                                    ErrorImageWidget(height: 100),
                              ),
                            ),
                          ),
                          title: Text(
                            notiPro.notifications[index].title.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            notiPro.notifications[index].description.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.greyText,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              notiPro.notifications[index].isRead == 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 8),
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              Text(
                                CustomDateFormat.formatDateOnly(notiPro
                                    .notifications[index].createdAt
                                    .toString()),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colors.greyText,
                                ),
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


// Row(
//                   children: [
                   
//                     VerticalDivider(),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
                       
//                       ],
//                     ),
//                   ],
//                 ),
            