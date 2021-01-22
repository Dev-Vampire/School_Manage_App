import 'package:flutter/material.dart';

import '../constants.dart';

class ThuView extends StatefulWidget {
  @override
  _ThuViewState createState() => _ThuViewState();
}

class _ThuViewState extends State<ThuView> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Text(
        "THURSDAY",
        style: TextStyle(color: thirdColor),
      ),
    );
  }
}