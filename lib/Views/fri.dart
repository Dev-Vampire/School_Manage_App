import 'package:flutter/material.dart';
import '../constants.dart';

class FriView extends StatefulWidget {
  @override
  _FriViewState createState() => _FriViewState();
}

class _FriViewState extends State<FriView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "FRIDAY",
        style: TextStyle(color: thirdColor),
      ),
    );
  }
}