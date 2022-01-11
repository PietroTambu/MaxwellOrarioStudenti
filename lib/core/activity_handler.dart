import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:maxwell_orario_studenti/pages/home_page.dart';
import 'package:maxwell_orario_studenti/pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/globals.dart' as globals;

class ActivityHandler extends StatefulWidget {
  const ActivityHandler({Key? key}) : super(key: key);

  @override
  _ActivityHandlerState createState() => _ActivityHandlerState();
}

class _ActivityHandlerState extends State<ActivityHandler> {

  bool isLoggedIn = globals.isSignedIn;

  _getDefaultClass () async {
    // Get Default class from SharedPreferences
    globals.setLoading(true);
    final prefs = await SharedPreferences.getInstance();
    const key = 'defaultClass';
    final value = prefs.getString(key) ?? '5ALS';
    globals.defaultClass = value;
    globals.setLoading(false);
  }

  _initializeFirebaseAuth() async {
      globals.auth.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
          globals.isSignedIn = false;
        } else {
          print('User is signed in!');
          globals.isSignedIn = true;
        }
        setState(() {
          isLoggedIn = globals.isSignedIn;
          print('reloaded logged in');
        });
      });

      globals.auth.idTokenChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
          globals.isSignedIn = false;
        } else {
          print('User is signed in!');
          globals.isSignedIn = true;
        }
        setState(() {
          isLoggedIn = globals.isSignedIn;
          print('reloaded logged in');
        });
      });

      globals.auth.userChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
          globals.isSignedIn = false;
        } else {
          print('User is signed in!');
          globals.isSignedIn = true;
        }
        setState(() {
          isLoggedIn = globals.isSignedIn;
          print('reloaded logged in');
        });
      });
  }

  @override
  void initState() {
    super.initState();
    _getDefaultClass();
    _initializeFirebaseAuth();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maxwell Orario Studenti',
      navigatorObservers: <NavigatorObserver>[globals.observer],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoaderOverlay(
              child:
              isLoggedIn ?
              HomePage(
                  classe: globals.defaultClass
              ) :
              const Welcome()
          )
    );
  }
}