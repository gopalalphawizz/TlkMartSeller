import 'package:alpha_work/Utils/fcm_helper.dart';
import 'package:alpha_work/Utils/shared_pref..dart';
import 'package:alpha_work/View/Profile/settings/settings.dart';
import 'package:alpha_work/ViewModel/addressViewModel.dart';
import 'package:alpha_work/ViewModel/authViewModel.dart';
import 'package:alpha_work/ViewModel/customerViewModel.dart';
import 'package:alpha_work/ViewModel/dashboardViewModel.dart';
import 'package:alpha_work/ViewModel/orderMgmtViewModel.dart';
import 'package:alpha_work/ViewModel/productMgmtViewModel.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/ViewModel/walletViewModel.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/noInternet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'Utils/color.dart';
import 'View/Splash/SplashScrreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'ViewModel/currencyViewModel.dart';
import 'ViewModel/languageViewModel.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FCMHelper.shared.listenNotificationInBackground(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceUtils.init();
  await FCMHelper.shared.intializeFirebase();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    print(details.exception.toString());
    print(details.library.toString());
    print(details.exceptionAsString().toString());
    print(details.stack.toString());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: appLoader()),
    );
  };
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ProfileViewModel>(
      create: (context) => ProfileViewModel(),
    ),
    ChangeNotifierProvider<AddressViewModel>(
      create: (context) => AddressViewModel(),
    ),
    ChangeNotifierProvider<WalletViewMaodel>(
      create: (context) => WalletViewMaodel(),
    ),
    ChangeNotifierProvider<CustomerViewModel>(
      create: (context) => CustomerViewModel(),
    ),
    ChangeNotifierProvider<ProductManagementViewModel>(
      create: (context) => ProductManagementViewModel(),
    ),
    ChangeNotifierProvider<OrderManagementViewModel>(
      create: (context) => OrderManagementViewModel(),
    ),
    ChangeNotifierProvider<DashboardViewModel>(
        create: (context) => DashboardViewModel()),
    ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(),
    ),
    ChangeNotifierProvider<LanguageViewModel>(
        create: (context) => LanguageViewModel()),
    ChangeNotifierProvider<CurrencyViewModel>(
        create: (context) => CurrencyViewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    firebaseSetup();
  }

  void _handleMessage(RemoteMessage message) {
    print("_handleMessage : ${message.data}");
  }

  firebaseSetup() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        print('Message also contained a notification: ${message.data}');
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true, // Required to display a heads up notification
          badge: true,
          sound: true,
        );
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  final themeNotifier = Provider.of<ThemeNotifier>(context);
    return InternetWidget(
      offline: FullScreenWidget(child: NoInternetScreen()),
      online: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alpha Vendor',
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('hi', 'IN'),
        ],
        themeMode: ThemeMode.light,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          cardColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: colors.primary_app,
          ).copyWith(
            secondary: colors.darkIcon,
            brightness: Brightness.light,
          ),
          canvasColor: Theme.of(context).colorScheme.lightWhite,
          dialogBackgroundColor: Theme.of(context).colorScheme.white,
          iconTheme: Theme.of(context).iconTheme.copyWith(
                color: colors.primary,
              ),
          primarySwatch: colors.primary_app,
          fontFamily: 'FuturaPT',
          brightness: Brightness.light,
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.only(right: 10, left: 10),
            labelStyle: TextStyle(
                color: colors.greyText, fontWeight: FontWeight.normal),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.boxBorder, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle:
                TextStyle(color: colors.greyText, fontWeight: FontWeight.w400),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.boxBorder, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: colors.boxBorder, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          textTheme: TextTheme(
              titleLarge: TextStyle(
                color: Theme.of(context).colorScheme.fontColor,
                fontWeight: FontWeight.w600,
                fontFamily: 'FuturaPT',
                fontSize: 24,
              ),
              titleMedium: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'FuturaPT',
                fontWeight: FontWeight.bold,
              ),
              bodySmall: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              )).apply(
            bodyColor: Theme.of(context).colorScheme.fontColor,
          ),
        ),

        darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          cardColor: Color(0xFF2D3438),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: colors.darkIcon,
            selectionColor: colors.darkIcon,
            selectionHandleColor: colors.darkIcon,
          ),
          brightness: Brightness.dark,
          hintColor: colors.white10,
          textTheme: TextTheme(
              titleLarge: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'FuturaPT',
                fontSize: 24,
              ),
              titleMedium: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'FuturaPT',
                fontWeight: FontWeight.bold,
              ),
              bodySmall: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              )),
        ),
        // themeMode: themeNotifier.getThemeMode(),
        // themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const SpalashScreen(),
          '/setting': (context) => ProfileSettingScreen(),
          // SpalashScreen  DashboardScreen1
        },
        // home: Container(
        //   child: Text(AppLocalizations.of(context)!.signInToYourAccount),
        // ),
      ),
    );
  }
}
