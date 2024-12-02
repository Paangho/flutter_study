import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String displayText = '0';
  double? previousValue;
  String? operator;
  bool isNewInput = true;
  bool isEqualPressed = false;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        // 초기화
        displayText = '0';
        previousValue = null;
        operator = null;
        isNewInput = true;
        isEqualPressed = false;
      } else if (['/', '*', '-', '+'].contains(value)) {
        // 연속 계산 처리
        if (previousValue != null && operator != null && !isNewInput) {
          previousValue =
              _calculate(previousValue!, double.parse(displayText), operator!);
          displayText = previousValue!.toStringAsFixed(2);
        } else {
          previousValue = double.parse(displayText);
        }
        operator = value; // 새로운 연산자 설정
        isNewInput = true;
        isEqualPressed = false; // 새로운 연산 시작 시 `=` 플래그 초기화
      } else if (value == '=') {
        // `=` 버튼 처리
        if (!isEqualPressed && previousValue != null && operator != null) {
          double currentValue = double.parse(displayText);
          double result = _calculate(previousValue!, currentValue, operator!);

          displayText = result.toStringAsFixed(2);
          previousValue = null; // 이전 값 초기화
          operator = null; // 연산자 초기화
          isNewInput = true;
          isEqualPressed = true; // `=` 버튼 눌림 상태 기록
        } else if (isEqualPressed) {
          // 연속 `=` 입력 시 추가 계산 방지
          displayText = displayText; // 화면 값 유지
        }
      } else if (value == '±') {
        // 부호 변경
        if (displayText != '0') {
          displayText = displayText.startsWith('-')
              ? displayText.substring(1)
              : '-$displayText';
        }
      } else if (value == '%') {
        // 백분율 처리
        displayText = (double.parse(displayText) / 100).toString();
      } else if (RegExp(r'^[0-9]$').hasMatch(value)) {
        // 숫자 입력 처리
        if (isNewInput || displayText == '0') {
          displayText = value;
          isNewInput = false;
        } else {
          displayText += value;
        }
        isEqualPressed = false; // 숫자 입력 시 `=` 플래그 초기화
      } else if (value == '.') {
        // 소수점 처리
        if (!displayText.contains('.')) {
          displayText += '.';
          isNewInput = false;
        }
        isEqualPressed = false; // 소수점 입력 시 `=` 플래그 초기화
      }
    });
  }

  double _calculate(double firstValue, double secondValue, String operator) {
    switch (operator) {
      case '+':
        return firstValue + secondValue;
      case '-':
        return firstValue - secondValue;
      case '*':
        return firstValue * secondValue;
      case '/':
        return secondValue != 0 ? firstValue / secondValue : double.nan;
      default:
        throw Exception('Invalid operator');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black54,
        title: Text(
          'Calculator',
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black12,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                displayText,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 1.3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: EdgeInsets.all(8.0),
              children: [
                ...['C', '±', '%', '/'].map((label) => _buildButton(label)),
                ...['7', '8', '9', '*'].map((label) => _buildButton(label)),
                ...['4', '5', '6', '-'].map((label) => _buildButton(label)),
                ...['1', '2', '3', '+'].map((label) => _buildButton(label)),
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('='),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label) {
    return GestureDetector(
      onTap: () => _onButtonPressed(label),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: label == '=' ? Colors.orange : Colors.grey[800],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
