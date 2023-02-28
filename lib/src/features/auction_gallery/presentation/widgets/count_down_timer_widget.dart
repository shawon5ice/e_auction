import 'dart:async';
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final int secondsRemaining;
  final VoidCallback whenTimeExpires;

  const CountDownTimer({Key? key, required this.secondsRemaining, required this.whenTimeExpires}) : super(key: key);

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
      formattedTime =
          "${_remainingTime.inDays.toString()}${days<=0?'':'Days, '}"
          "${(_remainingTime.inHours % 24).toString().padLeft(2, '0')}:"
          "${_remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
          "${_remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}";
    }
    return Text(formattedTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class MultiCountDownTimer extends StatefulWidget {
  const MultiCountDownTimer({super.key});

  @override
  _MultiCountDownTimerState createState() => _MultiCountDownTimerState();
}

class _MultiCountDownTimerState extends State<MultiCountDownTimer> {
  final List<int> _timers = [60, 120, 180]; // Set your list of timer durations here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Count Down Timer'),
      ),
      body: ListView.builder(
        itemCount: _timers.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Timer ${index + 1}'),
                  CountDownTimer(
                    secondsRemaining: _timers[index],
                    whenTimeExpires: () {
                      setState(() {
                        _timers[index] = 0;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
