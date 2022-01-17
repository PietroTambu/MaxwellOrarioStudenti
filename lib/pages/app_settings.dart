import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maxwell_orario_studenti/core/database.dart';
import 'package:maxwell_orario_studenti/pages/register/register.dart';
import '../style/colors.dart' as color;
import '../core/globals.dart' as globals;

class AppSettings extends StatefulWidget {
  AppSettings({
    Key? key,
    required this.internetConnection
  }) : super(key: key);

  bool internetConnection;

  @override
  State<AppSettings> createState() => _AppSettings();
}

class _AppSettings extends State<AppSettings> {

  bool signedIn = globals.isSignedIn;
  bool showEmail = false;

  final String _userName = globals.auth.currentUser?.displayName ?? '__error__';
  final String _userEmail = globals.auth.currentUser?.email ?? '__error__';

  emailVisibilityChange(bool value) {
    setState(() {
      showEmail = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 42),
                  const Text(
                    'Impostazioni',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                    ),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    icon: Icon(Icons.logout),
                    iconSize: 32,
                    onPressed: () {
                      globals.auth.signOut();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ExpansionTile(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Nome Utente:',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]
                ),
                children: <Widget>[
                  Text(
                    _userName,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Inserisci il nome utente per cambiarlo',
                    ),
                    onChanged: (String value) {
                      print(value);
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text('Cambia nome utente')
                  )
                ],
              ),
              const SizedBox(height: 15),
              ExpansionTile(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Email Utente:',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]
                ),
                children: <Widget>[
                  Text(
                    _userEmail,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Inserisci la tua email per cambiarla',
                    ),
                    onChanged: (String value) {
                      print(value);
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text('Cambia')
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Resetta la Password:',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(onPressed: () {
                    globals.auth.sendPasswordResetEmail(email: _userEmail);
                  }, child: Text('Invia Mail'))
                ],
              ),
              ElevatedButton(onPressed: () {
                UserController(globals.auth.currentUser!.uid).updateUserName('userName');
              }, child: Text('update Username'))
            ]
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
