import 'package:flutter/material.dart';

import '../constants.dart';

class TextBookView extends StatefulWidget {
  @override
  _TextBookViewState createState() => _TextBookViewState();
}

class _TextBookViewState extends State<TextBookView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "TextBook",
        style: TextStyle(color: thirdColor),
      ),
    );
  }
}