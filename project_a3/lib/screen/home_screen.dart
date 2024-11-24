import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int seconds = 0;
  Timer? timer;
  bool isRunning = false;

  /// 타이머 시작
  void _startTimer() {
    if (isRunning) return;

    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
    });
  }

  /// 타이머 스탑
  void _stopTimer() {
    if (!isRunning) return;

    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  ///타이머 초기화
  void _resetTimer() {
    if (isRunning) return;

    _stopTimer();
    setState(() {
      seconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Timer App',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70),
            _Timer(second: seconds),
            Spacer(),
            _Buttons(
              startPressed: _startTimer,
              stopPressed: _stopTimer,
              resetPressed: _resetTimer,
            ),
          ],
        ),
      ),
    );
  }
}

class _Timer extends StatelessWidget {
  final int second;

  const _Timer({
    required this.second,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue, width: 3),
      ),
      alignment: Alignment.center,
      child: Text(
        '$second',
        style: TextStyle(
          fontSize: 60.0,
          fontWeight: FontWeight.w700,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  final VoidCallback startPressed;
  final VoidCallback stopPressed;
  final VoidCallback resetPressed;

  const _Buttons({
    required this.startPressed,
    required this.stopPressed,
    required this.resetPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: startPressed,
            child: Text('Start!'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.white,
            ),
            onPressed: stopPressed,
            child: Text('Stop!'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: resetPressed,
            child: Text('Reset!'),
          ),
        ],
      ),
    );
  }
}
