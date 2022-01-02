import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart' as color;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List info = [];

  _initData() {
    DefaultAssetBundle.of(context).loadString('json/info.json').then((value) {
      info = json.decode(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.AppColor.homePageBackground,
        body: Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
                children: [
                  Row(
                      children: [
                        Text(
                            "Maxwell Studenti",
                            style: TextStyle(
                                fontSize: 24,
                                color: color.AppColor.homePageTitle,
                                fontWeight: FontWeight.w700
                            )
                        ),
                        Expanded(child: Container()),
                        Icon(Icons.arrow_back_ios,
                            size: 20,
                            color: color.AppColor.homePageIcons),
                        const SizedBox(width: 6),
                        Icon(Icons.calendar_today_outlined,
                            size: 20,
                            color: color.AppColor.homePageIcons),
                        const SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios,
                            size: 20,
                            color: color.AppColor.homePageIcons
                        ),
                      ]
                  ),
                  const SizedBox(height: 30),
                  Row(
                      children: [
                        Text(
                            "Your class:",
                            style: TextStyle(
                                fontSize: 20,
                                color: color.AppColor.homePageSubtitle,
                                fontWeight: FontWeight.w700
                            )
                        ),
                        Expanded(child: Container()),
                        Text(
                            "5ALS",
                            style: TextStyle(
                              fontSize: 20,
                              color: color.AppColor.homePageDetail,
                            )
                        ),
                        const SizedBox(width: 5,),
                        Icon(Icons.arrow_forward,
                            size: 20,
                            color: color.AppColor.homePageIcons),
                      ]
                  ),
                  const SizedBox(height: 20),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.AppColor.gradientFirst.withOpacity(0.75),
                              color.AppColor.gradientSecond.withOpacity(0.9),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(80),
                          ),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(5, 7),
                                blurRadius: 10,
                                color: color.AppColor.gradientSecond.withOpacity(0.3)
                            )
                          ]
                      ),
                      child: Container(
                          padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Next lesson:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: color.AppColor.homePageContainerTextSmall,
                                  )
                              ),
                              const SizedBox(height: 5),
                              Text(
                                  "Matematica",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: color.AppColor.homePageContainerTextSmall,
                                  )
                              ),
                              const SizedBox(height: 5),
                              Text(
                                  "prof.ssa Mannelli",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: color.AppColor.homePageContainerTextSmall,
                                  )
                              ),
                              const SizedBox(height: 16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.timer, size: 20, color: color.AppColor.homePageContainerTextSmall),
                                      const SizedBox(width: 5),
                                      Text(
                                          "60 min",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: color.AppColor.homePageContainerTextSmall,
                                          )
                                      )
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: const Offset(3, 5),
                                            blurRadius: 10,
                                            color: color.AppColor.gradientFirst.withOpacity(0.6),
                                        )
                                      ],
                                    ),
                                      child: const Icon(Icons.play_circle_fill, color: Colors.white, size: 60)
                                  ),
                                ],
                              )
                            ],
                          )
                      )
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 20),
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage("assets/card.jpg"),
                              fit: BoxFit.fill
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 40,
                                  offset: const Offset(8, 10),
                                  color: color.AppColor.gradientSecond.withOpacity(0.3),
                              ),
                              BoxShadow(
                                blurRadius: 10,
                                offset: const Offset(-2, -5),
                                color: color.AppColor.gradientSecond.withOpacity(0.3),
                              )
                            ]
                          )
                        ),
                        Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(right: 200, bottom: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage("assets/figure.png"),
                                ),
                            )
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 100,
                          margin: const EdgeInsets.only(left: 170, top: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You are doing great",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: color.AppColor.homePageDetail
                                )
                              ),
                              const SizedBox(height: 10),
                              RichText(text: TextSpan(
                                text: "Keep it up\n",
                                style: TextStyle(
                                  color: color.AppColor.homePagePlanColor,
                                  fontSize: 15,
                                ),
                                children: const [
                                  TextSpan(
                                    text: "stick to your plan"
                                  )
                                ]
                              ))
                            ]
                          )
                        )
                      ]
                    )
                  ),
                  Row(
                    children: [
                      Text(
                        "Area of focus",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: color.AppColor.homePageTitle
                        ),
                      )
                    ],
                  ),
                  Expanded(child: ListView.builder(
                    itemCount: info.length,
                    itemBuilder: (_, i){
                      return Row(
                        children: [
                          Container(
                            height: 170,
                            width: 200,
                            padding: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(
                                  info[i]["img"]
                                )
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: const Offset(5, 5),
                                  color: color.AppColor.gradientSecond.withOpacity(0.1),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: const Offset(-5, -5),
                                  color: color.AppColor.gradientSecond.withOpacity(0.1),
                                ),
                              ]
                            ),
                            child: Center(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "glues",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: color.AppColor.homePageDetail
                                  )
                                ),
                              )
                            )
                          )
                        ],
                      );
                    },
                  ))
                ]
            )
        )
    );
  }
}
