import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart' as color;
import 'home_page.dart';

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.AppColor.gradientFirst.withOpacity(0.9),
              color.AppColor.gradientSecond,
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          ),
        ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: 275,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                              },
                              icon: Icon(Icons.arrow_back_ios,
                                  size: 20,
                                  color: Colors.white
                              )
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.info_outline, size: 20 , color: Colors.white),
                        ]
                    ),
                    SizedBox(height: 20),
                    Text(
                        "Matematica",
                        style: TextStyle(
                          fontSize: 25,
                          color: color.AppColor.secondPageTitleColor,
                        )
                    ),
                    const SizedBox(height: 5),
                    Text(
                        "prof.ssa Mannelli",
                        style: TextStyle(
                          fontSize: 20,
                          color: color.AppColor.secondPageTitleColor,
                        )
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                color.AppColor.secondPageContainerGradient1stColor,
                                color.AppColor.secondPageContainerGradient2ndColor,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.timer, size: 20, color: color.AppColor.secondPageTitleColor),
                              const SizedBox(width: 5),
                              Text(
                                "60 min",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: color.AppColor.secondPageTitleColor
                                )
                              ),
                            ]
                          )
                        ),
                        Expanded(child: Container()),
                        Container(
                            width: 250,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    color.AppColor.secondPageContainerGradient1stColor,
                                    color.AppColor.secondPageContainerGradient2ndColor,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                )
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.handyman_outlined, size: 20, color: color.AppColor.secondPageTitleColor),
                                  const SizedBox(width: 5),
                                  Text(
                                      "Limiti di una funzione",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: color.AppColor.secondPageTitleColor
                                      )
                                  ),
                                ]
                            )
                        ),
                      ],
                    ),
                  ]
                )
              ),
              Expanded(child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  )
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "More Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: color.AppColor.circuitsColor
                          )
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: [
                            Icon(Icons.loop, size: 30, color: color.AppColor.loopColor)
                          ],
                        ),
                      ]
                    )
                  ]
                )
              ))
            ],
          )
      ),
    );
  }
}
