import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maxwell_orario_studenti/components/class_list.dart';
import 'package:maxwell_orario_studenti/core/database.dart';
import '../../style/colors.dart' as color;
import '../../core/globals.dart' as globals;

class RegisterDone extends StatefulWidget {
  const RegisterDone({
    Key? key,
    required this.userName
  }) : super(key: key);

  final String userName;

  @override
  State<RegisterDone> createState() => _RegisterDone();
}

class _RegisterDone extends State<RegisterDone> {

  @override
  void initState() {
    super.initState();
  }

  Future _register (String value) async {
    Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: const Text('Registrazione')),
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
      body: Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ciao ' + widget.userName,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                    'Scegli la tua classe'
                ),
              ],
            ),
            const SizedBox(height: 15,),
            Expanded(child: ClassList()),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
