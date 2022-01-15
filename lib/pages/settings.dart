import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maxwell_orario_studenti/core/database.dart';
import 'package:maxwell_orario_studenti/pages/register.dart';
import '../style/colors.dart' as color;
import '../core/globals.dart' as globals;

class Settings extends StatefulWidget {
  Settings({
    Key? key,
    required this.internetConnection
  }) : super(key: key);

  bool internetConnection;

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {

  bool signedIn = globals.isSignedIn;

  final String _userName = globals.auth.currentUser?.displayName ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: signedIn ? <Widget>
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                [
                  Text(
                    'Sign in as: $_userName',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        globals.auth.signOut();
                      },
                      child: Text('Esci')
                  )
                ],
              ),
              SizedBox(height: 15),
              ElevatedButton(onPressed: () {
                UserController(globals.auth.currentUser!.uid).updateUserName('userName');
              }, child: Text('update Username'))
            ] :
            [
              SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_) => const Register())
                    );
                  },
                  child: Text('Sign Up')
              )
            ]
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}