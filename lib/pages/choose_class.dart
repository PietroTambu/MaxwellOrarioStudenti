import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../models/Classes.dart';
import '../core/requests.dart';
import '../style/colors.dart' as color;
import '../core/globals.dart' as globals;


class ChooseClass extends StatefulWidget {
  const ChooseClass({Key? key,
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
  _ChooseClassState createState() => _ChooseClassState();
}


class _ChooseClassState extends State<ChooseClass> {

  late Future<Classes> futureClasses;
  String mode = globals.mode;

  _chooseClass(classe) async {
    await globals.updateClass(classe);
    Navigator.of(context).popUntil((route) => route.isFirst);
    widget.notifyParent();
  }


  void initState() {
    super.initState();
    futureClasses = fetchClasses();
    mode = widget.mode;
  }

  @override
  void didUpdateWidget(ChooseClass oldWidget) {
    super.didUpdateWidget(oldWidget);
    mode = widget.mode;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,
        ),
        title: Center(child:
        Text(
            'Scegli la tua classe',
            style: TextStyle(
              color: mode == 'dark' ? color.AppColorDarkMode.secondaryText : color.AppColorLightMode.secondaryText,
            )
        )),
        flexibleSpace: Container(
          color: mode == 'dark' ? color.AppColorDarkMode.appBar : color.AppColorLightMode.appBar,
        ),
      ),
      body: Container(
        color: mode == 'dark' ? color.AppColorDarkMode.background : color.AppColorLightMode.background,
        child: Center(
          child: FutureBuilder<Classes>(
            future: futureClasses,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                context.loaderOverlay.hide();
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ListView.builder(
                    itemCount: snapshot.data!.min.length,
                    itemBuilder: (_, i){
                      return Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.analytics.logEvent(name: 'class_selected', parameters: <String, dynamic>{
                              'class_name': snapshot.data!.min[i],
                            });
                            _chooseClass(snapshot.data!.min[i]);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(mode == 'dark' ? color.AppColorDarkMode.primary : color.AppColorLightMode.primary),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            elevation: MaterialStateProperty.all<double>(3),
                            overlayColor: MaterialStateProperty.all<Color>(mode == 'dark' ? color.AppColorDarkMode.secondaryText.withOpacity(0.25) : color.AppColorLightMode.secondaryText.withOpacity(0.25)),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  snapshot.data!.min[i].length > 4 ?
                                  snapshot.data!.min[i].substring(0, 4) :
                                  snapshot.data!.min[i],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,
                                  ),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    snapshot.data!.complete[i],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: mode == 'dark' ? color.AppColorDarkMode.secondaryText : color.AppColorLightMode.secondaryText,
                                    ),
                                )
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              context.loaderOverlay.show();
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
