import 'package:flutter/material.dart';
import 'package:tabbar_practice/const/tabs.dart';

class BasicAppbarTabbarScreen extends StatelessWidget {
  const BasicAppbarTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABS.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            'BasicAppBarScreen',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              indicatorColor: Colors.red,
              indicatorWeight: 4.0,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              labelColor: Colors.yellow,
              unselectedLabelColor: Colors.purple,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w100
              ),
              tabs: TABS
                  .map(
                    (e) => Tab(
                  icon: Icon(
                    e.icon,
                  ),
                  child: Text(
                    e.label,
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: TABS
              .map(
                (e) => Center(
                  child: Icon(e.icon),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
