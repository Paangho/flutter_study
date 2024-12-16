import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> choices = [
    'assets/fist.png',
    'assets/scissors.png',
    'assets/hand-paper.pn

  int userChoiceIndex = 0;
  int computerChoiceIndex = 0;
  String resultText = '게임을 시작하세요!';

  void generateComputerChoice(int userChoice) {
    setState(() {
      userChoiceIndex = userChoice;
      computerChoiceIndex = Random().nextInt(3);
      determineResult();
    });
  }

  void determineResult() {
    if (userChoiceIndex == computerChoiceIndex) {
      resultText = '무승부';
    } else if ((userChoiceIndex == 0 && computerChoiceIndex == 1) ||
        (userChoiceIndex == 1 && computerChoiceIndex == 2) ||
        (userChoiceIndex == 2 && computerChoiceIndex == 0)) {
      resultText = '승리!';
    } else {
      resultText = '패배!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          '가위바위보 게임',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "User's\nChoice",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Computer\n  Choice',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  choices[userChoiceIndex],
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  choices[computerChoiceIndex],
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          Text(
            resultText,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: choices
                  .asMap()
                  .entries
                  .map(
                    (e) => ElevatedButton(
                      onPressed: () {
                        generateComputerChoice(e.key);
                      },
                      child: Image.asset(
                        e.value,
                        width: 30,
                        height: 30,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        elevation: 5,
                        shadowColor: Colors.grey,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
