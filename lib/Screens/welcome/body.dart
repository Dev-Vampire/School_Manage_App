import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_end_flutter/Screens/signin/login_screen.dart';
import 'package:front_end_flutter/Screens/signup/signup_screen.dart';
import 'package:front_end_flutter/constants.dart';
import 'rounded_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "University of Computer Studies - Kalay",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: thirdColor,
                  letterSpacing: 0.5),
            ),
            SizedBox(height: 60),
            SvgPicture.asset("assets/icons/welcome.svg",
                height: size.height * 0.2),
            SizedBox(height: 120),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
