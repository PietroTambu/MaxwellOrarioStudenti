import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../models/Classes.dart';
import '../core/requests.dart';
import '../style/colors.dart' as color;
import '../core/globals.dart' as globals;


class ChooseClass extends StatefulWidget {
  ChooseClass({Key? key,
    required this.notifyParent
  }) : super(key: key);

  final Function() notifyParent;
  final FirebaseAnalytics analytics = globals.analytics;
  final FirebaseAnalyticsObserver observer = globals.observer;

  @override
  _ChooseClassState createState() => _ChooseClassState();
}


class _ChooseClassState extends State<ChooseClass> {
  late Future<Classes> futureClasses;

  _chooseClass(classe) async {
    await globals.updateClass(classe);
    globals.goHomePage(context);
    widget.notifyParent();
  }

  @override
  void initState() {
    super.initState();
    futureClasses = fetchClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Center(child: const Text('Scegli la tua classe')),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xff0f17ad).withOpacity(0.6),
                  const Color(0xFF6588f4),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: Center(
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
                          backgroundColor: MaterialStateProperty.all<Color>(color.AppColor.homePageDetail),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                          elevation: MaterialStateProperty.all<double>(3),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.indigo.withOpacity(0.4)),
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
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  snapshot.data!.complete[i],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
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
      )
    );
  }
}
