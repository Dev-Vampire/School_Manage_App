import 'package:flutter/material.dart';
import 'package:front_end_flutter/Views/main/mon_main.dart';
import 'package:front_end_flutter/constants.dart';
import 'package:front_end_flutter/Views/fri.dart';
import 'package:front_end_flutter/Views/mon.dart';
import 'package:front_end_flutter/Views/thu.dart';
import 'package:front_end_flutter/Views/tue.dart';
import 'package:front_end_flutter/Views/wed.dart';

class HeaderPage extends StatefulWidget {
  @override
  _HeaderPageState createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UCS - Kalay'),
        centerTitle: true,
        bottom: TabBar(
          labelColor: secondColor,
          labelStyle: TextStyle(fontSize: 20, letterSpacing: 0.5),
          controller: _tabController,
          indicatorColor: secondColor,
          unselectedLabelColor: Colors.grey[500],
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(text: "Mon"),
            Tab(text: "Tue"),
            Tab(text: "Wed"),
            Tab(text: "Thu"),
            Tab(text: "Fri")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MonView(),
          TueView(),
          WedView(),
          ThuView(),
          FriView(),
        ],
      ),
    );
  }
}
