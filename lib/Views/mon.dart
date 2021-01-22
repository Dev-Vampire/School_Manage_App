import 'package:flutter/material.dart';
import '../constants.dart';

class MonView extends StatefulWidget {
  @override
  _MonViewState createState() => _MonViewState();
}

class _MonViewState extends State<MonView> {
  // final MonDao monDao = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "MONDAY",
        style: TextStyle(color: thirdColor),
      ),
    );
  }
}
