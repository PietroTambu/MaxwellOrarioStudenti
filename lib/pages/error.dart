import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import '../models/Error.dart';
import '../style/colors.dart' as color;

class ErrorPage extends StatefulWidget {
  final int error;

  const ErrorPage({Key? key, required this.error }) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {

  static List errorCodes = [
    [
      '101',
      'Bad Request',
      'La richiesta al Server non è andata a buon fine; riprova più tardi o prova a cambiare connessione internet.'
    ],
    [
      '102',
      'Device Offline',
      'Sembra che il tuo dispositivo non sia connesso ad internet; l\'applicazione deve scaricare dei file importanti. Connettiti ad internet e riprova.'
    ],
    [
      '103',
      'Server Offline',
      'Al momento il server è irraggiungibile; si prega di riprovare più tardi.'
    ],
    [
      '104',
      'Internal Error',
      'Si è verificato un errore interno all\'applicazione. Prova a riavviare l\'applicazione assicurandoti di non averla attiva in background.'
    ],
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Maxwell Orario Studenti')),
          flexibleSpace: Container(
            color: color.AppColorDarkMode.appBar,
          ),
        ),
        backgroundColor: color.AppColorDarkMode.background,
        body: Container(
            color: color.AppColorDarkMode.background,
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
                children: [
                  Expanded(child: Container(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: color.AppColorDarkMode.primary,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 270,
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Si è verificato un errore',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: color.AppColorDarkMode.primaryText,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(left: 30, right: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          "Codice: ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            letterSpacing: 0.75,
                                            color: color.AppColorDarkMode.secondaryText,
                                          ),
                                        ),
                                        Text(
                                          errorCodes[widget.error][0],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: color.AppColorDarkMode.primaryText,
                                                letterSpacing: 1
                                            )
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          "Causa: ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              letterSpacing: 0.75,
                                              color: color.AppColorDarkMode.secondaryText
                                          ),
                                        ),
                                        Text(
                                            errorCodes[widget.error][1],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: color.AppColorDarkMode.primaryText,
                                                letterSpacing: 1
                                            )
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                        errorCodes[widget.error][2],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: color.AppColorDarkMode.secondaryText,
                                          letterSpacing: 0.3
                                        )
                                    )
                                  ],
                                )
                              )
                            ]
                          ),
                        )
                        ),
                      ),
                    ),
                  )
                ]
            )
        )
    );
  }
}
