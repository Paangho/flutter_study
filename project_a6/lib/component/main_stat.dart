import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  const MainStat({super.key});

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    );

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              '서울',
              style: ts.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '2024-04-01 11:00',
              style: ts.copyWith(
                fontSize: 10.0,
              ),
            ),
            SizedBox(height: 7.0),
            Image.asset(
              'asset/img/good.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            SizedBox(height: 7.0),
            Text(
              '보통',
              style: ts.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '나쁘지 않네요!',
              style: ts.copyWith(
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
