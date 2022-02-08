import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../models/Lessons.dart';
import '../models/Classes.dart';
import 'package:http/http.dart' as http;
import '../core/globals.dart' as globals;
import '../pages/error.dart';


fetchLessonsFromStorage(String classe, [int error = 3]) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$classe.json');
    String class_data = await file.readAsString();
    print('JSON found on Storage');
    return Lessons.fromJson(json.decode(class_data));
  } catch (e) {
    print('Cannot fetch Data, Error: $error');
    runApp(MaterialApp(home: ErrorPage(error: error)));
  }
}

fetchClassesFromStorage([int error = 3]) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/listaClassi.json');
    String class_data = await file.readAsString();
    print('JSON found on Storage');
    return Classes.fromJson(json.decode(class_data));
  } catch (e) {
    print('Cannot fetch Data, Error: $error');
    runApp(MaterialApp(home: ErrorPage(error: error)));
  }
}

Future<Lessons> fetchLessons(classe) async {
  try {
    if (globals.lessonsLoaded) {
      return await fetchLessonsFromStorage(classe, 0);
    } else {
      final response = await http
          .get(Uri.parse('https://maxwell-orario-studenti-61c8f-default-rtdb.europe-west1.firebasedatabase.app/classi/$classe.json'))
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$classe.json');
        final text = response.body;
        await file.writeAsString(text);
        print('JSON Saved and Synchronized');
        globals.lessonsLoaded = true;
        return Lessons.fromJson(jsonDecode(response.body));
      } else {
        return await fetchLessonsFromStorage(classe, 0);
      }
    }
  } on SocketException {
    return await fetchLessonsFromStorage(classe, 1);
  } on TimeoutException catch (e) {
    return await fetchLessonsFromStorage(classe, 2);
  } catch (e) {
    return await fetchLessonsFromStorage(classe, 3);
  }

}

Future<Classes> fetchClasses() async {
  try {
    final response = await http
        .get(Uri.parse('https://maxwell-orario-studenti-61c8f-default-rtdb.europe-west1.firebasedatabase.app/listaClassi.json'))
        .timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/listaClassi.json');
      final text = response.body;
      await file.writeAsString(text);
      print('JSON Saved and Synchronized');
      return Classes.fromJson(jsonDecode(response.body));
    } else {
      return await fetchClassesFromStorage(0);
    }
  } on SocketException {
    return await fetchClassesFromStorage(1);
  } on TimeoutException catch (e) {
    return await fetchClassesFromStorage(2);
  } catch (e) {
    return await fetchClassesFromStorage(3);
  }
}

