import 'dart:async';
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final int secondsRemaining;
  final VoidCallback whenTimeExpires;
  final Color color;

  const CountDownTimer({Key? key, required this.secondsRemaining, required this.whenTimeExpires, required this.color}) : super(key: key);

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late Timer _timer;
  Duration _remainingTime = const Duration();

  @override
  void initState() {
    super.initState();
    _remainingTime = Duration(seconds: widget.secondsRemaining);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime.inSeconds < 1) {
          _timer.cancel();
        } else {
          _remainingTime -= const Duration(seconds: 1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = "";
    if(_remainingTime.inSeconds==0){
      formattedTime = "Expired!";
    }else{
      int days = _remainingTime.inDays;
      formattedTime ="Remaining: "
          "${_remainingTime.inDays.toString()}${days<=0?'':' Days, '}"
          "${(_remainingTime.inHours % 24).toString().padLeft(2, '0')}:"
          "${_remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
          "${_remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}";
    }
    return Text(formattedTime,style: TextStyle(fontWeight: FontWeight.bold,color: widget.color));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
