import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../style/colors.dart' as color;
import '../core/globals.dart' as globals;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';
  String _error = '';

  late FocusNode _userNameFocus;
  late FocusNode _userEmailFocus;
  late FocusNode _userPasswordFocus;

  final RegisterController = TextEditingController();
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userNameFocus = FocusNode();
    _userEmailFocus = FocusNode();
    _userPasswordFocus = FocusNode();
    RegisterController.addListener(_handleChange);
  }

  void _handleChange() {
    setState(() {
      _userEmail = RegisterController.text;
      _userPassword = RegisterController.text;
      _userName = RegisterController.text;
    });
  }

  Future _register (String value) async {
    try {
      UserCredential result = await globals.auth.createUserWithEmailAndPassword(
        email: userEmailController.text,
        password: userPasswordController.text,
      );
      globals.auth.currentUser?.updateDisplayName(userNameController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'weak-password') {
          _error = 'Password troppo debole';
          userPasswordController.text = '';
        } else if (e.code == 'email-already-in-use') {
          _error = 'Esiste già un account con questa mail.';
        }
      });
    } catch (e) {
      _error = e.toString();
    }
    Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
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
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10),
              child: const Text(
                'Nome Utente:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ), // NomeUtente
            const SizedBox(height: 7),
            Container(
              decoration: BoxDecoration(
                color: color.AppColor.homePagdeDetail,
                borderRadius:  BorderRadius.circular(32),
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Name / Nickname",
                ),
                focusNode: _userNameFocus,
                controller: userNameController,
                onSubmitted: (String value) { _userEmailFocus.requestFocus(); },
              ),
            ), // NomeUtenteField
            const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10),
              child: const Text(
                'Email:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ), // EmailUtente
            const SizedBox(height: 7),
            Container(
              decoration: BoxDecoration(
                color: color.AppColor.homePagdeDetail,
                borderRadius:  BorderRadius.circular(32),
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Email",
                ),
                controller: userEmailController,
                onSubmitted: (String value) { _userPasswordFocus.requestFocus(); },
              ),
            ), // EmailUtenteField
            const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10),
              child: const Text(
                'Password:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ), // PasswordUtente
            const SizedBox(height: 7),
            Container(
              decoration: BoxDecoration(
                color: color.AppColor.homePagdeDetail,
                borderRadius:  BorderRadius.circular(32),
              ),
              child: TextField(
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Password"
                ),
                obscureText: true,
                onSubmitted: _register,
                controller: userPasswordController,
              ),
            ), // PasswordUtenteFIeld
            _error != '' ?
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      Text(
                          _error,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  )
                )
            :
                Container(),
            const SizedBox(height: 15,),
            ElevatedButton(
                onPressed: () { _register('none'); },
                child: Text('Registrati')
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}