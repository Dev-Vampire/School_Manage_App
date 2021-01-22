import 'package:flutter/material.dart';

import '../constants.dart';

class TueView extends StatefulWidget {
  @override
  _TueViewState createState() => _TueViewState();
}

class _TueViewState extends State<TueView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "TUESDAY",
        style: TextStyle(color: thirdColor),
      ),
    );
  }
}
