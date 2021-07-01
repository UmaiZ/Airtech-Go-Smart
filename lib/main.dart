import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'helpers/helpers.dart';
import 'helpers/global_variable.dart';

import 'pages/pages.dart';
import 'providers/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = new FlutterSecureStorage();
  String id = await storage.read(key: "id");
  String ID = await storage.read(key: "ID");

  print(id);
  runApp(
    EasyLocalization(
      child: RestartWidget(
        child: MyApp(),
      ),
      path: 'resources',
      saveLocale: true,
      fallbackLocale: Locale(
          id == null ? 'en' : id.toString(), ID == null ? 'EN' : ID.toString()),
      supportedLocales: [
        Locale('en', 'EN'),
        Locale('id', 'ID'),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  String sendToken;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void initState() {

    Future.delayed(Duration.zero, () {
      this.firebaseCloudMessagingListeners();});

  }

  void firebaseCloudMessagingListeners() {
    _firebaseMessaging.getToken().then((deviceToken) {
      sendToken = deviceToken;
      print("Firebase Device token: $sendToken");

    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeChangerProvider()),
      ],
      child: Consumer<ThemeChangerProvider>(
        builder: (context, theme, child) {
          return GetMaterialApp(
            title: 'Air Tech Ecommerce',
            defaultTransition: Transition.topLevel,
            transitionDuration: Duration(milliseconds: 800),
            debugShowCheckedModeBanner: false,
            theme: themeData(context),
            darkTheme: darkThemeData(context),
            themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: SplashPage(),
          );
        },
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
