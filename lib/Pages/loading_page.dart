import 'package:flutter/material.dart';
import 'package:front_end_flutter/constants.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [firstColor, fourthColor],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Center(
            child: Text(
          "Joseph Thang",
          style: TextStyle(
              color: thirdColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        )),
      ),
    );
  }
}
