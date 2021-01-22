import 'package:flutter/material.dart';

import '../constants.dart';

class WedView extends StatefulWidget {
  @override
  _WedViewState createState() => _WedViewState();
}

class _WedViewState extends State<WedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "WEDNESDAY",
        style: TextStyle(color: thirdColor),
      ),
    );
  }
}