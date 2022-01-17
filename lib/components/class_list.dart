import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../core/requests.dart';
import '../models/Classes.dart';
import '../core/globals.dart' as globals;
import '../style/colors.dart' as color;


class ClassList extends StatefulWidget {
  ClassList({Key? key,}) : super(key: key);

  final FirebaseAnalytics analytics = globals.analytics;
  final FirebaseAnalyticsObserver observer = globals.observer;

  @override
  _ClassListState createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  late Future<Classes> futureClasses;

  _chooseClass(classe) async {
    await globals.updateClass(classe);
    globals.goHomePage(context);
  }

  @override
  void initState() {
    super.initState();
    futureClasses = fetchClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
      ),
    );
  }
}
