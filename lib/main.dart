import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'firebase_options.dart';
import './core/globals.dart' as globals;
import 'pages/home_page.dart';
import 'package:flutter/services.dart';
import 'pages/error.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  const key = 'defaultClass';
  final value = prefs.getString(key) ?? '5ALS';
  print('default Class: $value');
  globals.defaultClass = value;

  runApp(MyApp(classe: value));
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoaderOverlay(
        child: HomePage(classe: classe, analytics: analytics, observer: observer),
      )
    );
  }
}
