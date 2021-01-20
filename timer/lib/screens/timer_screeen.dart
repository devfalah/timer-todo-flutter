import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'home_screen.dart';

class TimerScreen extends StatefulWidget {
  final int minutes;
  final Color color;

  TimerScreen({this.minutes, this.color});
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  CountDownController _controller = CountDownController();
  bool _isPause = false;

  // Timer timer;
  // void startTimer() {
  //   final oneSecond = Duration(seconds: 1);
  //   totalTime = minutes * 60 + seconds;
  //   timer = Timer.periodic(oneSecond, (timer) {
  //     setState(() {
  //       if (totalTime < 1)
  //         timer.cancel();
  //       else {
  //         if (seconds == 0) minutes -= 1;
  //         totalTime -= 1;
  //         seconds = (totalTime % 60);
  //       }
  //     });
  //   });
  // }
  push() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
      ModalRoute.withName('/'),
    );
  }

  // ignore: missing_return
  Future<bool> onBack() async {
    Alert(
      context: context,
      type: AlertType.none,
      title: "هل ترغب في انهاء الجلسة",
      style: AlertStyle(
        titleStyle: TextStyle(color: Colors.white),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "لا",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.grey,
        ),
        DialogButton(
          child: Text(
            "نعم",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: push,
          color: Colors.red,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBack,
      child: Theme(
        data: ThemeData(
          primarySwatch: Colors.red,
          brightness: Brightness.dark,
        ),
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: widget.color,
                  child: CircularCountDownTimer(
                    // Countdown duration in Seconds
                    duration: widget.minutes * 60,

                    // Controller to control (i.e Pause, Resume, Restart) the Countdown
                    controller: _controller,

                    // Width of the Countdown Widget
                    width: MediaQuery.of(context).size.width / 1.5,

                    // Height of the Countdown Widget
                    height: MediaQuery.of(context).size.height / 1.5,

                    // Default Color for Countdown Timer
                    color: Colors.black,

                    // Filling Color for Countdown Timer
                    fillColor: widget.color,

                    // Background Color for Countdown Widget
                    backgroundColor: null,

                    // Border Thickness of the Countdown Circle
                    strokeWidth: 5.0,

                    // Begin and end contours with a flat edge and no extension
                    strokeCap: StrokeCap.butt,

                    // Text Style for Countdown Text
                    textStyle: TextStyle(
                        fontSize: 22.0,
                        color: widget.color,
                        fontWeight: FontWeight.bold),

                    // true for reverse countdown (max to 0), false for forward countdown (0 to max)
                    isReverse: true,

                    // true for reverse animation, false for forward animation
                    isReverseAnimation: true,

                    // Optional [bool] to hide the [Text] in this widget.
                    isTimerTextShown: true,

                    // Function which will execute when the Countdown Ends
                    onComplete: () {
                      Alert(
                        style: AlertStyle(
                          animationType: AnimationType.fromTop,
                          backgroundColor: Colors.blueGrey,
                        ),
                        context: context,
                        type: AlertType.success,
                        title: "أحسنت",
                        buttons: [
                          DialogButton(
                            color: Colors.red,
                            child: Text(
                              "Complete",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      ).show();
                    },
                  ),
                ),
                CircleAvatar(
                  backgroundColor: widget.color,
                  radius: 40,
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
                    onPressed: () {
                      setState(() {
                        if (_isPause) {
                          _isPause = false;
                          _controller.resume();
                        } else {
                          _isPause = true;
                          _controller.pause();
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: onBack,
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "الغاء",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
