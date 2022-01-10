import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../style/colors.dart' as color;
import '../core/globals.dart' as globals;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  String _userEmail = '';
  String _userPassword = '';
  String _error = '';

  final LoginController = TextEditingController();

  @override
  void initState() {
    super.initState();
    LoginController.addListener(_handleChange);
  }

  void _handleChange() {
    setState(() {
      _userEmail = LoginController.text;
      _userPassword = LoginController.text;
    });
  }

  Future _login () async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _userEmail,
          password: _userPassword
      );
      Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _error = 'No user found for that email.';
        });
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setState(() {
          _error = 'Wrong password provided for that user.';
        });
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Center(child: const Text('Accedi')),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: color.AppColor.homePagdeDetail,
                  borderRadius:  BorderRadius.circular(32),
                ),
                child: TextField(
                  textCapitalization: TextCapitalization.none,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Email",
                  ),
                  onChanged: (String value){
                    setState(() {
                      _userEmail = value;
                    });
                  },
                  autofocus: true,
                ),
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                  color: color.AppColor.homePagdeDetail,
                  borderRadius:  BorderRadius.circular(32),
                ),
                child: TextField(
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
                  onChanged: (String value){
                    setState(() {
                      _userPassword = value;
                    });
                  },
                  autofocus: true,
                ),
              ),
              SizedBox(height: 15,),
              _error != '' ?
                  Container(
                    child: Column(
                      children: [
                        Text(_error),
                        SizedBox()

                      ],
                    )
                  ) : Container(),
              ElevatedButton(
                  onPressed: _login,
                  child: Text('Login')
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
