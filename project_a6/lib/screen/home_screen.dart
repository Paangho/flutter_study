import 'package:flutter/material.dart';
import 'package:project_a6/component/category_stat.dart';
import 'package:project_a6/component/hourly_stat.dart';
import 'package:project_a6/component/main_stat.dart';
import 'package:project_a6/const/color.dart';
import 'package:project_a6/model/stat_model.dart';
import 'package:project_a6/repository/stat_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: StatRepository.fetchData(
              itemCode: ItemCode.PM10,
            ),
            builder: (context, snapshot) {
              print(snapshot.hasError);
              print(snapshot.data);
              return Column(
                children: [
                  MainStat(),
                  SizedBox(height: 5.0),
                  CategoryStat(),
                  HourlyStat(),
                ],
              );
            }
          ),
        ));
  }
}
