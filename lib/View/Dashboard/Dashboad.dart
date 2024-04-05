import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Utils/shared_pref..dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/AUTH/LOGIN/loginpage.dart';
import 'package:alpha_work/View/Customer/customer.dart';
import 'package:alpha_work/View/Dashboard/RatingnReview/ratingReview.dart';
import 'package:alpha_work/View/Dashboard/TotalDelivery/totalDelivery.dart';
import 'package:alpha_work/View/Dashboard/TotalOrder/totalOrder.dart';
import 'package:alpha_work/View/Dashboard/notification/notification.dart';
import 'package:alpha_work/View/Dashboard/stockMgmt/stockMgmt.dart';
import 'package:alpha_work/View/ORDER/ordermanagement.dart';
import 'package:alpha_work/View/Payment/payment.dart';
import 'package:alpha_work/View/Product/addProduct.dart';
import 'package:alpha_work/View/Product/productManagement.dart';
import 'package:alpha_work/View/Profile/profile/Profile.dart';
import 'package:alpha_work/View/Profile/settings/settings.dart';
import 'package:alpha_work/View/Profile/widgets/logoutSheet.dart';
import 'package:alpha_work/View/Store/store.dart';
import 'package:alpha_work/View/Wallet/wallet.dart';
import 'package:alpha_work/ViewModel/dashboardViewModel.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:alpha_work/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Router/router.dart';
import '../../Utils/color.dart';
import '../../Widget/CommonTextWidget/commontext.dart';

class DashboardScreen1 extends StatefulWidget {
  const DashboardScreen1({super.key});

  @override
  State<DashboardScreen1> createState() => _DashboardScreen1State();
}

class _DashboardScreen1State extends State<DashboardScreen1> {
  late DashboardViewModel dashProvider;
  late ProfileViewModel vendorProvider;
  final ScrollController _controller = ScrollController();

  getData() async {
    try {
      await vendorProvider.getvendorProfileData();
      await dashProvider.getDashboardData("WeekEarn");
    } catch (e, stack) {
      PreferenceUtils.setString(PrefKeys.jwtToken, '');
      PreferenceUtils.setString(PrefKeys.isLoggedIn, 'false');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
      Utils.showTost(msg: "Session token has expired, please login again");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashProvider = Provider.of<DashboardViewModel>(context, listen: false);
    vendorProvider = Provider.of<ProfileViewModel>(context, listen: false);
    getData();

    _tooltipBehavior = TooltipBehavior(enable: true);
    _tooltipBehavior1 = TooltipBehavior(enable: true);
    //  _tabController =  TabController(length: 2, vsync: true);
  }

  late TooltipBehavior _tooltipBehavior;
  late TooltipBehavior _tooltipBehavior1;
  // late TabController _tabController;

  List items = [
    {
      'id': 0,
      'name': 'Total Sale',
      'image': Images.sale_image,
      'color': Color(0xFFE17A1A).withOpacity(0.3),
    },
    {
      'id': 1,
      'name': 'Total Order',
      'image': Images.order_image,
      'color': Color(0xFFE92068).withOpacity(0.3),
    },
    {
      'id': 2,
      'name': 'Stock Management',
      'image': Images.stock_image,
      'color': Color(0xFFCB43D7).withOpacity(0.3),
    },
    {
      'id': 3,
      'name': 'Customer',
      'image': Images.customer_image,
      'color': Color(0xFF00C2ED).withOpacity(0.3),
    },
    {
      'id': 4,
      'name': 'Total Deliveries',
      'image': Images.delivery_image,
      'color': Color(0xFF0C77C8).withOpacity(0.3),
    },
    {
      'id': 5,
      'name': 'Rating Review',
      'image': Images.rating_image,
      'color': Color(0xFFEDB900).withOpacity(0.3),
    },
  ];

  final navigator = NavigateToRouter();
  String getCardVal(int index) {
    switch (index) {
      case 0:
        return dashProvider.dashData.totalSale.toString();
      case 1:
        return dashProvider.dashData.totalOrders.toString();
      case 2:
        return dashProvider.dashData.stockManagement.toString();
      case 3:
        return dashProvider.dashData.totalCustomers.toString();
      case 4:
        return dashProvider.dashData.totalDelivery.toString();
      case 5:
        return dashProvider.dashData.ratingsNdReviews.toString();
      default:
        return " ";
    }
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent - 180,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    dashProvider = Provider.of<DashboardViewModel>(context);
    vendorProvider = Provider.of<ProfileViewModel>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return dashProvider.isLoading
        ? appLoader()
        : Scaffold(
            backgroundColor: colors.lightGrey,
            drawer: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DrawerHeader(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: colors.buttonColor,
                          image: DecorationImage(
                              opacity: 0.5,
                              image: AssetImage(
                                Images.onboardingBg_light,
                              ),
                              fit: BoxFit.contain)),
                      //BoxDecoration
                      child: Center(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: CachedNetworkImageProvider(
                                vendorProvider.vendorData.image.toString()),
                            onBackgroundImageError: (exception, stackTrace) =>
                                ErrorImageWidget(height: height * .09),
                          ),
                          title: Text(
                            "${vendorProvider.vendorData.fName.toString()} ${vendorProvider.vendorData.lName.toString()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(),
                                )),
                            child: Text(
                              "View Profile",
                              style: TextStyle(
                                  color: colors.lightTextColor,
                                  fontSize: 12,
                                  decorationColor: colors.lightTextColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ) //UserAccountDrawerHeader
                      ),

                  //DrawerHeader
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "OverView",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            selected: true,
                            selectedColor: colors.homeBGGradient1,
                            leading: ImageIcon(
                              AssetImage(Images.dashImagesFilled[0]),
                            ),
                            title: const Text(' Dashboard '),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: ImageIcon(
                              AssetImage(Images.dashImages[1]),
                            ),
                            title:
                                const DrawerText(text: 'Order Managemnt', ''),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: OrderManagement(
                                        index: 0,
                                      )));
                            },
                          ),
                          ListTile(
                            leading: ImageIcon(
                              AssetImage(Images.dashImages[2]),
                            ),
                            title: const DrawerText(
                                text: 'Product Management', ''),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const ProductManagementScreen()));
                            },
                          ),
                          ListTile(
                            leading: ImageIcon(
                              AssetImage(Images.dashImages[3]),
                            ),
                            title: const DrawerText(text: 'Customer', ''),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const CustomerScreen()));
                            },
                          ),
                          // ListTile(
                          //   leading: ImageIcon(
                          //     AssetImage(Images.dashImages[4]),
                          //   ),
                          //   title: const DrawerText(
                          //       text: 'Analytics and Reports', ''),
                          //   onTap: () {
                          //     Navigator.pop(context);
                          //   },
                          // ),
                          ListTile(
                            leading: ImageIcon(
                              AssetImage(Images.dashImages[5]),
                            ),
                            title: const DrawerText(text: 'Wallet', ''),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: WalletScreen()))
                                  .then((value) => dashProvider
                                      .getDashboardData("WeekEarn"));
                            },
                          ),
                          ListTile(
                            leading: ImageIcon(
                              AssetImage(Images.dashImages[6]),
                            ),
                            title: const DrawerText(text: 'Settings', ''),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const ProfileSettingScreen()));
                            },
                          ),
                          ListTile(
                            leading: ImageIcon(
                              AssetImage(Images.dashImages[7]),
                            ),
                            title: const DrawerText(text: 'Payment', ''),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const PaymentScreen()));
                            },
                          ),
                          ListTile(
                            leading: ImageIcon(
                              AssetImage(Images.dashImages[8]),
                            ),
                            title: const DrawerText(text: 'Store Setting', ''),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: EditStoreDetailScreen(
                                          vendor: vendorProvider.vendorData)));
                            },
                          ),
                          ListTile(
                            leading: ImageIcon(
                              AssetImage(Images.logOut),
                              color: Colors.red,
                            ),
                            title: Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => LogoutBottomSheet(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // backgroundColor: Colors.blue[50],
            body: dashProvider.isLoading
                ? appLoader()
                : RefreshIndicator(
                    color: colors.buttonColor,
                    displacement: 40.0,
                    strokeWidth: 2.0,
                    semanticsLabel: 'Pull to refresh',
                    semanticsValue: 'Refresh',
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 2));
                      await getData();
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 16),
                          // height: height * .33,
                          decoration: BoxDecoration(
                            color: colors.buttonColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Image.asset(
                                  Images.profile_bg_circle,
                                  height: height * .2,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AppBar(
                                    forceMaterialTransparency: true,
                                    centerTitle: true,
                                    title: const Text(
                                      "Seller Dashboard",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    leading: Builder(builder: (context) {
                                      return IconButton(
                                        icon: Image.asset(
                                          Images.hamburgerMenuIcon,
                                          color: Colors.white,
                                          height: 25,
                                        ),
                                        onPressed: () =>
                                            Scaffold.of(context).openDrawer(),
                                      );
                                    }),
                                    actions: [
                                      IconButton(
                                        icon: Badge(
                                          isLabelVisible: dashProvider
                                                      .dashData.notification
                                                      .toString() ==
                                                  '0'
                                              ? false
                                              : true,
                                          label: Text(
                                            dashProvider.dashData.notification
                                                .toString(),
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          child: Image.asset(
                                            Images.notification,
                                            color: Colors.white,
                                            height: 25,
                                          ),
                                        ),
                                        onPressed: () => Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: NotificationScreen(),
                                                    type: PageTransitionType
                                                        .rightToLeft))
                                            .then((value) => dashProvider
                                                .getDashboardData("WeekEarn")),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Total Sale",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: colors.lightGrey),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        VerticalDivider(width: 5),
                                        Text(
                                          dashProvider.dashData.ratingsNdReviews
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      dashProvider.dashData.totalSale
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontFamily: 'Montreal',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Divider(color: Colors.transparent),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Sold Out",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: colors.lightGrey),
                                            ),
                                            Text(
                                              dashProvider.dashData.soldOut
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * .04,
                                          child: VerticalDivider(
                                            color: colors.lightTextColor,
                                            thickness: 2,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductManagementScreen(),
                                              )).then((value) => null),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Total Products",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: colors.lightGrey),
                                              ),
                                              Text(
                                                dashProvider
                                                    .dashData.totalProduct
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 28,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * .04,
                                          child: VerticalDivider(
                                            color: colors.lightTextColor,
                                            thickness: 2,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: TotalOrderScreen(
                                                      total: dashProvider
                                                          .dashData.totalOrders
                                                          .toString()),
                                                ));
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                "Total Order",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: colors.lightGrey),
                                              ),
                                              Text(
                                                dashProvider
                                                    .dashData.totalOrders
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 28,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _controller,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 15,
                                            crossAxisSpacing: 15),
                                    itemCount: items.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        print(index);
                                        switch (index) {
                                          case 0:
                                            _scrollDown();
                                          case 1:
                                            Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child: TotalOrderScreen(
                                                            total: dashProvider
                                                                .dashData
                                                                .totalOrders
                                                                .toString()),
                                                        type: PageTransitionType
                                                            .rightToLeft))
                                                .then((value) => getData());

                                            break;
                                          case 3:
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: CustomerScreen(),
                                                    type: PageTransitionType
                                                        .rightToLeft));

                                            break;
                                          case 5:
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    child:
                                                        RatingAndRewiewScreen(
                                                            image:
                                                                vendorProvider
                                                                    .vendorData
                                                                    .image
                                                                    .toString(),
                                                            name: vendorProvider
                                                                .vendorData
                                                                .fName
                                                                .toString()),
                                                    type: PageTransitionType
                                                        .rightToLeft));

                                            break;
                                          case 2:
                                            Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child:
                                                            StockManagementScreen(),
                                                        type: PageTransitionType
                                                            .rightToLeft))
                                                .then((value) => getData());
                                            break;
                                          case 4:
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    child:
                                                        TotalDeliveredProductScreen(),
                                                    type: PageTransitionType
                                                        .rightToLeft));
                                            break;

                                          default:
                                            null;
                                        }
                                      },
                                      child: Container(
                                        height: height * .1,
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: height * .07,
                                              width: height * .07,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: items[index]['color'],
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Image.asset(
                                                  items[index]['image']),
                                            ),
                                            Spacer(),
                                            Text(
                                              items[index]['name'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                color: colors.greyText,
                                              ),
                                            ),
                                            Expanded(
                                              child: AutoSizeText(
                                                getCardVal(index),
                                                maxFontSize: 28,
                                                minFontSize: 16,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily: 'Montreal',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(color: Colors.transparent),
                                Container(
                                  color: Colors.white,
                                  height: 300,
                                  child: ContainedTabBarView(
                                    tabs: const [
                                      Text('Week'),
                                      Text('Month'),
                                      Text('Year'),
                                    ],
                                    tabBarProperties: TabBarProperties(
                                      background: Container(
                                          decoration: const BoxDecoration(
                                        boxShadow: [],
                                      )),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 32.0,
                                        vertical: 15.0,
                                      ),
                                      indicator: ContainerTabIndicator(
                                        width: 100,
                                        radius: BorderRadius.circular(4.0),
                                        color: const Color.fromARGB(
                                            255, 71, 168, 177),
                                      ),
                                      labelColor: Colors.white,
                                      unselectedLabelColor: Colors.grey[400],
                                    ),
                                    views: [
                                      _Views(),
                                      _Views(),
                                      _Views(),
                                    ],
                                    onChange: (index) {
                                      if (index == 0) {
                                        dashProvider
                                            .getDashboardData("WeekEarn");
                                      } else if (index == 1) {
                                        dashProvider
                                            .getDashboardData("MonthEarn");
                                      } else {
                                        dashProvider
                                            .getDashboardData("yearEarn");
                                      }
                                    },
                                  ),
                                ),
                                const Divider(color: Colors.transparent),
                                dashProvider.circleData.isEmpty
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Categories Wise Product Count',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                                child: SfCircularChart(
                                                    legend: const Legend(
                                                        orientation:
                                                            LegendItemOrientation
                                                                .vertical,
                                                        position:
                                                            LegendPosition.left,
                                                        iconWidth: 10,
                                                        alignment:
                                                            ChartAlignment.far,
                                                        isVisible: true),
                                                    tooltipBehavior:
                                                        _tooltipBehavior1,
                                                    series: <CircularSeries>[
                                                  // Render pie chart

                                                  PieSeries<ChartData, String>(
                                                      dataSource: dashProvider
                                                          .circleData,

                                                      //     [
                                                      //   //   // Bind data source
                                                      //   //   ;
                                                      //   ChartData('Product1', 5),
                                                      //   ChartData('Product2', 7),
                                                      // ],
                                                      xValueMapper:
                                                          (ChartData data, _) =>
                                                              data.x,
                                                      yValueMapper:
                                                          (ChartData data, _) =>
                                                              data.y,
                                                      dataLabelSettings:
                                                          const DataLabelSettings(
                                                              isVisible: true)),
                                                ])),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () => Navigator.push(
                      context,
                      PageTransition(
                          child: AddProdutScreen(isFromHome: true),
                          type: PageTransitionType.rightToLeft))
                  .then((value) => getData()),
              backgroundColor: colors.buttonColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
  }

  Widget _Views() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <CartesianSeries>[
            LineSeries<ChartData, String>(
                dataSource: dashProvider.chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                // Renders the marker
                markerSettings: const MarkerSettings(isVisible: true))
          ])),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
