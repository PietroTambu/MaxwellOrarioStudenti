library maxwell.globals;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maxwell_orario_studenti/core/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

int navIndex = 1;
String defaultClass = '5ALS';
bool isLoading = false;
bool internetConnection = false;
List en_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

// Firebase Analytics
FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

// Firebase Authentication
FirebaseAuth auth = FirebaseAuth.instance;
bool isSignedIn = false;

// Firebase Firestore
FirebaseFirestore firestore = FirebaseFirestore.instance;


// methods
goHomePage (context) {
    navIndex = 1;
    Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
}

updateClass(String newClass) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'defaultClass';
    prefs.setString(key, newClass);
    print('new classe stored: $newClass');
    UserController(auth.currentUser!.uid).updateUserClasse(newClass);
    defaultClass = newClass;
}

setLoading(bool state) {
    isLoading = state;
}

getDate(int index, String format) {
    final DateTime now = DateTime.now();
    final DateFormat weekdayFormatter = DateFormat('EEEE');
    final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

    int todayIndex = en_days.indexOf(weekdayFormatter.format(now));

    int difference = 0;

    if (index != todayIndex) {
        if (todayIndex == 6) {
            todayIndex = 0;
            difference = index - todayIndex + 1;
        } else {
            difference = index - todayIndex;
        }
    }

    final DateTime returnDateTime = DateTime.now().add(Duration(days: difference));

    final String returnWeekDay = weekdayFormatter.format(returnDateTime);
    final String returnDate = dateFormatter.format(returnDateTime);


    if (format == 'WeekDay') {
        return returnWeekDay.toString();
    } else if (format == 'date') {
        return returnDate.toString();
    } else {
        return 'invalid props';
    }
}

getTodayIndex() {
    final DateTime now = DateTime.now();
    final DateFormat weekdayFormatter = DateFormat('EEEE');
    final String today = weekdayFormatter.format(now);
    final int index = en_days.indexOf(today);
    if (index == 6) {
        return 0;
    } else {
        return index;
    }
}

validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

