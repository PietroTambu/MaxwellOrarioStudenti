import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './globals.dart' as globals;

class UserController {
  final String uid;
  String userName = '';
  String email = '';
  String classe = '5ALS';

  UserController(this.uid);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  setUserData(String userName, String email, String classe) async {
    await users.doc(uid).set({
      'userName': userName,
      'email': email,
      'classe': classe
    });
  }

  updateUserName(String userName) async {
    print(uid);
    await users.doc(uid).update({
      'userName': userName
    });
  }

  updateUserEmail(String email) async {
    print(uid);
    await users.doc(uid).update({
      'email': email
    });
  }

  updateUserClasse(String classe) async {
    print(uid);
    await users.doc(uid).update({
      'classe': classe
    });
  }

}
