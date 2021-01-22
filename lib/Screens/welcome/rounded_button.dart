import 'package:flutter/material.dart';
import 'package:front_end_flutter/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = secondColor,
    this.textColor = firstColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      height: 58,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlatButton(
          color: secondColor,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
                letterSpacing: 0.5),
          ),
        ),
      ),
    );
  }
}
