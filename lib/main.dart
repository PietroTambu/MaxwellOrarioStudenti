import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'firebase_options.dart';
import './core/globals.dart' as globals;
import 'pages/home_page.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'pages/error.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();

  const defClass = 'defaultClass';
  const colorMode = 'colorMode';
  final defaultClass = prefs.getString(defClass) ?? 'None';
  final colorModePref = prefs.getString(colorMode) ?? 'dark';

  if (defaultClass == 'None') {
    globals.defaultClass = '5ALS';
    globals.firstAccess = true;
  } else {
    globals.defaultClass = defaultClass;
    globals.firstAccess = false;
  }
  print('default Class: ${globals.defaultClass}');
  globals.mode = colorModePref;

  runApp(MyApp(classe: defaultClass == 'None' ? '5ALS' : defaultClass));
}

class MyApp extends StatelessWidget {

  const MyApp({
    Key? key,
    required this.classe,
  }) : super(key: key);

  final String classe;
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maxwell Orario Studenti',
      navigatorObservers: <NavigatorObserver>[observer],
      home: LoaderOverlay(
        child: HomePage(classe: classe, analytics: analytics, observer: observer),
      )
    );
  }
}
