import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer/screens/timer_screeen.dart';
import 'package:timer/widget/item.dart';
import 'package:timer/widget/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List qoutes = [
    'تذكر دوماُ ما أنت بارع فيه وتمسك به',
    'النِضال من أجل التميُّز هو ما يحفزك.',
    'الطريق إلى التميِّز نادراً ما يكون مزدحماً.',
    'كُلما زاد الارتفاع الذي تحلّق عليه، ازداد المنظر جمالاً.',
    'إنّ المرء هو أصل كل ما يفعل.',
    'الحياة إمّا أن تكون مُغامرة جرئية، أو لا شيء.',
    'اغرس اليوم شجرة تنم في ظِلها غداً.',
    'أعمالُنا تُحدِدنا بقدر ما نحدد نحن أعمالنا.',
    'الأمل هو اليأس من اليأس',
    'بدل ان تلعن الظلام اوقد شمعة',
    'فى لفظة القمة شئ يقول لك قــــــــــــم',
  ];
  int randomQoutes = 0;

  Random random = Random();
  @override
  void initState() {
    final Stream newsStream = new Stream.periodic(
        Duration(seconds: 15),
        (_) => setState(() {
              randomQoutes = random.nextInt(qoutes.length - 1);
            }));
    newsStream.listen((e) {
      // print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dw = MediaQuery.of(context).size.width;

    return Scaffold(
      endDrawer: MainDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.tealAccent),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  BuildItemTimer(
                    dw: dw,
                    color: Colors.red,
                    imgUrl: "assets/images/tomato.png",
                    text: '25',
                    onTap: () {
                      return Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => TimerScreen(
                            minutes: 25,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
                  BuildItemTimer(
                    dw: dw,
                    color: Colors.orange,
                    imgUrl: "assets/images/carrot.png",
                    text: '15',
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => TimerScreen(
                          minutes: 15,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  BuildItemTimer(
                    dw: dw - 50,
                    color: Colors.yellow,
                    imgUrl: "assets/images/lemon.png",
                    text: '10',
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => TimerScreen(
                          minutes: 10,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  BuildItemTimer(
                    dw: dw,
                    color: Colors.brown,
                    imgUrl: "assets/images/pineapple.png",
                    text: '60',
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => TimerScreen(
                          minutes: 60,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  ),
                  BuildItemTimer(
                    dw: dw,
                    color: Colors.lime,
                    imgUrl: "assets/images/mango.png",
                    text: '45',
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => TimerScreen(
                          minutes: 45,
                          color: Colors.lime,
                        ),
                      ),
                    ),
                  ),
                  BuildItemTimer(
                    dw: dw,
                    color: Colors.pink,
                    imgUrl: "assets/images/strawberry.png",
                    text: '30',
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => TimerScreen(
                          minutes: 30,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                child: Card(
                  color: Colors.black45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   height: 100,
                      //   child: Image.asset(
                      //     "assets/images/app_icon.png",
                      //   ),
                      // ),
                      Text(
                        qoutes[randomQoutes],
                        style: GoogleFonts.changa(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
