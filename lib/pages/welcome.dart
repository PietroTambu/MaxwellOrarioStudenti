import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../style/colors.dart' as color;
import '../core/globals.dart' as globals;
import 'choose_class.dart';

class Welcome extends StatefulWidget {
  const Welcome({
    Key? key,
    required this.analytics,
    required this.observer,
    required this.notifyParent,
    required this.mode
  }) : super(key: key);

  final Function() notifyParent;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final String mode;

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  // LOGICA
  String mode = globals.mode;

  @override
  void initState() {
    super.initState();
    mode = widget.mode;
  }

  @override
  void didUpdateWidget(Welcome oldWidget) {
    super.didUpdateWidget(oldWidget);
    mode = widget.mode;
  }

  // GRAFICA
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mode == 'dark' ? color.AppColorDarkMode.background : color.AppColorLightMode.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
                'Benvenuto',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,
              ),
            ),
          ),
          const SizedBox(height: 60),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Orario Scolastico Studenti \n\n IIS J.C. Maxwell 2021 - 2022',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: mode == 'dark' ? color.AppColorDarkMode.secondaryText : color.AppColorLightMode.secondaryText,
              ),
            ),
          ),
          const SizedBox(height: 100),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            child: const SizedBox(
                width: 80,
                height: 60,
                child: Icon(Icons.arrow_forward, size: 30,)
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (_) => ChooseClass(
                    notifyParent: widget.notifyParent,
                    analytics: widget.analytics,
                    observer: widget.observer,
                    mode: mode,
                  ))
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
