import 'package:flutter/material.dart';

import '../constants.dart';

class OldQuestionView extends StatefulWidget {
  @override
  _OldQuestionViewState createState() => _OldQuestionViewState();
}

class _OldQuestionViewState extends State<OldQuestionView> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Text(
        "OldQuestion",
        style: TextStyle(color: thirdColor),
      ),
    );
  }
}