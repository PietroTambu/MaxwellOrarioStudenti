import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maxwell_orario_studenti/core/database.dart';
import 'package:maxwell_orario_studenti/pages/register/register.dart';
import '../style/colors.dart' as color;
import '../core/globals.dart' as globals;

class AppSettings extends StatefulWidget {
  const AppSettings({
    Key? key,
  }) : super(key: key);

  @override
  State<AppSettings> createState() => _AppSettings();
}

class _AppSettings extends State<AppSettings> {

  bool signedIn = globals.isSignedIn;
  bool showEmail = false;

  String _userName = globals.auth.currentUser?.displayName ?? '__error__';
  final String _userEmail = globals.auth.currentUser?.email ?? '__error__';
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();

  updateUserName() async {
    if (userNameController.text.length > 2 && userNameController.text.length < 20) {
      globals.auth.currentUser?.updateDisplayName(userNameController.text);
      UserController(globals.auth.currentUser!.uid).updateUserName(userNameController.text);
      setState(() {
        _userName = userNameController.text;
        userNameController.text = '';
      });
    } else if (userNameController.text.length < 3) {
      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: const Text('Attenzione'),
        content: const Text('UserName troppo corto'),
        actions: <Widget>[
          TextButton(
            onPressed: () { Navigator.pop(context, 'OK'); },
            child: const Text('OK'),
          ),
        ],
      ));
    } else {
      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: const Text('Attenzione'),
        content: const Text('UserName troppo lungo'),
        actions: <Widget>[
          TextButton(
            onPressed: () { Navigator.pop(context, 'OK'); },
            child: const Text('OK'),
          ),
        ],
      ));
    }
  }

  updateUserEmail() async {
    bool validEmail = globals.validateEmail(userEmailController.text);
    if (validEmail && _userEmail != userEmailController.text) {
      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: const Text('Attenzione'),
        content: const Text('Una volta cambiato l\'indirizzo email sarà necessario autenticarsi nuovamente.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await globals.auth.currentUser!.updateEmail(userEmailController.text);
              await UserController(globals.auth.currentUser!.uid).updateUserEmail(userEmailController.text.toLowerCase());
              Navigator.pop(context);
              globals.auth.signOut();
            },
            child: const Text('OK'),
          ),
        ],
      ));
    } else {
      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: const Text('Attenzione'),
        content: const Text('l\'indirizzo email inserito non è valido.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {Navigator.pop(context); userEmailController.text = '';},
            child: const Text('OK'),
          ),
        ],
      ));
    }
  }

  resetPassword() async {
    await globals.auth.sendPasswordResetEmail(email: _userEmail);
    showDialog(context: context, builder: (BuildContext context) => AlertDialog(
      title: const Text('Attenzione'),
      content: Text('Una Mail è stata inviata a: $_userEmail. \n\nDopo aver reimpostato la password si consiglia di ri-autenticarsi.'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:
          LinearGradient(
              colors: [
                const Color(0xFF6588f4).withOpacity(0.3),
                const Color(0xff7eb5fd).withOpacity(0.2),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp
          ),
        ),
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
                    children: [
                      Text(
                        _userName,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]
                ),
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Inserisci un nuovo nome utente',
                    ),
                    textAlign: TextAlign.center,
                    controller: userNameController,
                  ),
                  ElevatedButton(
                      onPressed: updateUserName,
                      child: const Text('Cambia Username')
                  )
                ],
              ),
              const SizedBox(height: 15),
              ExpansionTile(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Email:',
                        style: TextStyle(
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
                      hintText: 'Inserisci una nuova email per cambiarla',
                    ),
                    textAlign: TextAlign.center,
                    controller: userEmailController,
                  ),
                  ElevatedButton(
                      onPressed: updateUserEmail,
                      child: const Text('Cambia Email')
                  )
                ],
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Resetta la Password:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(onPressed: resetPassword,
                        child: const Text('Invia Mail')
                    )
                  ],
                ),
              ),
            ]
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
