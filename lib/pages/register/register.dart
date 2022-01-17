import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maxwell_orario_studenti/core/database.dart';
import 'package:maxwell_orario_studenti/pages/register/register_done.dart';
import '../../style/colors.dart' as color;
import '../../core/globals.dart' as globals;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  String _error = '';

  late FocusNode _userNameFocus;
  late FocusNode _userEmailFocus;
  late FocusNode _userPasswordFocus;

  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userNameFocus = FocusNode();
    _userEmailFocus = FocusNode();
    _userPasswordFocus = FocusNode();
  }

  Future _register (String value) async {
    if (globals.validateEmail(userEmailController.text)) {
      if (userNameController.text.length > 1) {
        try {
          UserCredential result = await globals.auth.createUserWithEmailAndPassword(
            email: userEmailController.text,
            password: userPasswordController.text,
          );
          globals.auth.currentUser?.updateDisplayName(userNameController.text);
          UserController(globals.auth.currentUser!.uid).setUserData(
            userNameController.text,
            userEmailController.text,
            '5ALS',
          );
          Navigator.push(context, MaterialPageRoute(
              builder: (_) => RegisterDone(userName: userNameController.text)
          ));
        } on FirebaseAuthException catch (e) {
          setState(() {
            if (e.code == 'weak-password') {
              _error = 'La password è troppo debole';
              userPasswordController.text = '';
            } else if (e.code == 'email-already-in-use') {
              _error = 'Esiste già un account con questa mail.';
            }
          });
        } catch (e) {
          _error = e.toString();
        }
      } else {
        setState(() {
          _error = 'Il nome utente contenere almeno 2 caratteri';
        });
      }
    } else {
     setState(() {
       _error = 'Inserisci una mail valida';
     });
    }
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
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 10, top: 20),
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
                IconButton(onPressed:
                    () { _register('none'); },
                    icon: const Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.black,
                        size: 30,

                    ),
                ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
