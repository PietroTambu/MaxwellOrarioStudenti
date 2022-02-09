import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:maxwell_orario_studenti/pages/choose_class.dart';
import '../firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';
import '../style/colors.dart' as color;
import '../core/globals.dart' as globals;
import 'dart:developer' as developer;
import '../components/ElevatedButtonCustom.dart';
import '../models/Lessons.dart';
import '../core/requests.dart';

class HomePage extends StatefulWidget {

  HomePage({
    Key? key,
    required this.classe,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  String classe;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<Lessons> futureLessons;

  int index = 0;
  List days = ['Lunedì', 'Martedì', 'Mercoledì', 'Giovedì', 'Venerdì', 'Sabato'];
  bool isLoading = globals.isLoading;
  String mode = globals.mode;
  bool firstAccess = globals.firstAccess;

  Future<void> logAppOpen() async {
    await widget.analytics.logAppOpen();
  }

  _nextDay() {
    setState(() {
      if (index < 5) {
        index += 1;
      }
    });
  }
  _prevDay() {
    setState(() {
      if (index > 0) {
        index -= 1;
      }
    });
  }
  _getPrevDayIndex() {
    if (index == 0) {
      return 5;
    } else {
      return index - 1;
    }
  }
  _getNextDayIndex() {
    if (index == 5) {
      return 0;
    } else {
      return index + 1;
    }
  }

  refresh() {
    setState(() {
      firstAccess = globals.firstAccess;
      widget.classe = globals.defaultClass;
      futureLessons = fetchLessons(widget.classe);
    });
  }

  changeMode() async {
    await globals.updateColorMode();
    setState(() {
      mode = globals.mode;
    });
  }

  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }


  Widget _homePage() {
    return Container(
        color: mode == 'dark' ? color.AppColorDarkMode.background : color.AppColorLightMode.background,
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Column(
            children: [
              Row(
                  children: [
                    Text(
                        "Classe corrente:",
                        style: TextStyle(
                            fontSize: 20,
                            color: mode == 'dark' ? color.AppColorDarkMode.secondaryText : color.AppColorLightMode.secondaryText,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7
                        )
                    ),
                    Expanded(child: Container()),
                    FutureBuilder<Lessons>(
                      future: futureLessons,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          context.loaderOverlay.hide();
                          return Text(
                              snapshot.data!.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: mode == 'dark' ? color.AppColorDarkMode.secondaryText : color.AppColorLightMode.secondaryText,
                              )
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        context.loaderOverlay.show();
                        return Container();
                      },
                    ),
                    const SizedBox(width: 5,),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_) => ChooseClass(
                                  notifyParent: refresh,
                                  analytics: widget.analytics,
                                  observer: widget.observer,
                                  mode: mode,
                              ))
                          );
                        },
                        icon: Icon(Icons.arrow_forward,
                          size: 20,
                          color: mode == 'dark' ? color.AppColorDarkMode.secondaryText : color.AppColorLightMode.secondaryText,
                        )
                    ),
                  ]
              ),
              const SizedBox(height: 10),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: mode == 'dark' ? color.AppColorDarkMode.primary : color.AppColorLightMode.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Container(
                      padding: const EdgeInsets.only(left: 30, right: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder<Lessons>(
                            future: futureLessons,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return RichText(
                                    text: TextSpan(
                                        text: days[index] + " \n",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: globals.getDate(index, 'date'),
                                              style: const TextStyle(
                                                fontSize: 20,
                                              )
                                          )
                                        ]
                                    ));
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return Container();
                            },
                          ),
                          Expanded(child: Container()),
                          Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:  mode == 'dark' ? color.AppColorDarkMode.secondary : color.AppColorLightMode.secondary
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.timer, size: 20, color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText),
                                    const SizedBox(width: 5),
                                    FutureBuilder<Lessons>(
                                      future: futureLessons,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                              snapshot.data!.week_days[index].length.toString() + ' ore',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText
                                              )
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text('${snapshot.error}');
                                        }
                                        return Container();
                                      },
                                    )
                                  ]
                              )
                          ),
                        ],
                      )
                  )
              ), //Header
              const SizedBox(height: 15),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyElevatedButton(
                      onPressed: _prevDay,
                      width: MediaQuery.of(context).size.width / 2 - 25,
                      height: 45,
                      mode: mode,
                      padding: const EdgeInsets.only(left: 0, right: 8),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      disable: index == 0,
                      child: Container(child:
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_ios, size: 24, color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,),
                            const SizedBox(width: 5),
                            Text(
                              days[_getPrevDayIndex()],
                              style: TextStyle(
                                  color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1
                              ),
                            )
                          ]
                      )
                      ),
                    ),
                    MyElevatedButton(
                      onPressed: _nextDay,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      width: MediaQuery.of(context).size.width / 2 - 25,
                      height: 45,
                      mode : mode,
                      padding: const EdgeInsets.only(left: 8, right: 0),
                      disable: index == 5,
                      child: Container(child:
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              days[_getNextDayIndex()],
                              style: TextStyle(
                                  color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.arrow_forward_ios, size: 24, color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,)

                          ]
                      ),
                      ),
                    ),
                  ]
              ),
              FutureBuilder<Lessons>(
                future: futureLessons,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(child: Container(
                      margin: const EdgeInsets.only(bottom: 25, top: 15),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: Container(
                          decoration: BoxDecoration(
                            color: mode == 'dark' ? color.AppColorDarkMode.primary : color.AppColorLightMode.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ListView.builder(
                              itemCount: snapshot.data!.week_days[index].length,
                              itemBuilder: (_, i){
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                              color: mode == 'dark' ? color.AppColorDarkMode.secondary : color.AppColorLightMode.secondary,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              snapshot.data!.week_days[index][i]['hour'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,
                                              ),
                                            )
                                        ),
                                        Container(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                              color: mode == 'dark' ? color.AppColorDarkMode.secondary : color.AppColorLightMode.secondary,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data!.week_days[index][i]['subject'],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 19,
                                                      color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,
                                                    ),
                                                  ),
                                                  Container(
                                                      child: Row(
                                                          children: [
                                                            Icon(Icons.timer, size: 15, color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,),
                                                            const SizedBox(width: 3),
                                                            Text(
                                                              snapshot.data!.week_days[index][i]['lesson_time'],
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontSize: 17,
                                                                color: mode == 'dark' ? color.AppColorDarkMode.primaryText : color.AppColorLightMode.primaryText,
                                                              ),
                                                            ),
                                                          ]
                                                      )
                                                  )

                                                ]
                                            )
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Container();
                },
              ),
            ]
        )
    );
  }

  Widget _chooseClass() {
    return Container(
        color: mode == 'dark' ? color.AppColorDarkMode.background : color.AppColorLightMode.background,
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: ChooseClass(
          analytics: widget.analytics,
          observer: widget.observer,
          mode: mode,
          notifyParent: refresh,
        )
    );
  }

  @override
  void initState() {
    super.initState();
    logAppOpen();
    futureLessons = fetchLessons(widget.classe);
    index = globals.getTodayIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      'Maxwell Orario Studenti',
                      style: TextStyle(
                        color: mode == 'dark' ? color.AppColorDarkMode.secondaryText : color.AppColorLightMode.secondaryText,
                      )
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: mode == 'dark' ? color.AppColorDarkMode.secondaryText : color.AppColorLightMode.secondaryText,
                    ),
                    onPressed: changeMode,
                  ),
                ]
              )
          ),
          flexibleSpace: Container(
            // color: color.AppColorDarkMode.appBar,
            color: mode == 'dark' ? color.AppColorDarkMode.appBar : color.AppColorLightMode.appBar,
          ),
        ),
        body:
        firstAccess ?
        _chooseClass()
            :
        _homePage()
    );
  }
}
