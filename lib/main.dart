import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import './core/globals.dart' as globals;
import '../core/activity_handler.dart';

Future<void> main() async {
  // Widgets initializing
  WidgetsFlutterBinding.ensureInitialized();

  // Portrait mode only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Establishing Firebase connection
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ActivityHandler();
  }
}
