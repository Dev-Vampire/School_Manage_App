import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_end_flutter/NetworkHandler.dart';
import 'package:front_end_flutter/Screens/signin/login_screen.dart';
import 'package:front_end_flutter/constants.dart';
import 'package:front_end_flutter/widgets/bottom_nav.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool vis = true;
  final _globalKey = GlobalKey<FormState>();

  NetworkHandler networkHandler = NetworkHandler();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String errText;
  bool validate = false;
  bool circular = false;

  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create An Account",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: thirdColor,
                    letterSpacing: 0.5),
              ),
              SizedBox(height: 30),
              SvgPicture.asset("assets/icons/signup.svg",
                  height: size.height * 0.2,),
              SizedBox(height: 40),
              usernameTextField(),
              SizedBox(height: 10),
              emailTextField(),
              SizedBox(height: 10),
              passwordTextField(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 0.5,
                      color: thirdColor,
                    ),
                  ),
                  SizedBox(width: 60),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: secondColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              SizedBox(height: 28),
              InkWell(
                onTap: () async {
                  setState(() {
                    circular = true;
                  });
                  await checkUser();
                  if (_globalKey.currentState.validate() && validate) {
                    Map<String, String> data = {
                      "username": _usernameController.text,
                      "email": _emailController.text,
                      "password": _passwordController.text
                    };
                    print(data);
                    var responseRegister =
                        await networkHandler.post("/user/register", data);

                    //Login Logic added here
                    if (responseRegister.statusCode == 200 ||
                        responseRegister.statusCode == 201) {
                      Map<String, String> data = {
                        "username": _usernameController.text,
                        "password": _passwordController.text,
                      };
                      var response =
                          await networkHandler.post("/user/login", data);

                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        Map<String, dynamic> output =
                            json.decode(response.body);
                        print(output["token"]);
                        await storage.write(
                            key: "token", value: output["token"]);
                        setState(() {
                          validate = true;
                          circular = false;
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNav(),
                            ),
                            (route) => false);
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Netwok Error")));
                      }
                    }

                    //Login Logic end here

                    setState(() {
                      circular = false;
                    });
                  } else {
                    setState(() {
                      circular = false;
                    });
                  }
                },
                child: circular
                    ? CircularProgressIndicator()
                    : Container(
                        alignment: Alignment.center,
                        width: size.width * 0.4,
                        height: size.height * 0.064,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: secondColor,
                        ),
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                              color: firstColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkUser() async {
    if (_usernameController.text.length == 0) {
      setState(() {
        validate = false;
        errText = "Username can't be Empty";
      });
    } else {
      var response = await networkHandler
          .get("/user/checkusername/${_usernameController.text}");
      if (response["status"]) {
        setState(() {
          validate = false;
          errText = "Username already taken";
        });
      } else {
        setState(() {
          validate = true;
        });
      }
    }
  }

  usernameTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 36),
      width: double.infinity,
      height: 68,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: secondColor,
        child: Container(
          alignment: Alignment.center,
          child: TextFormField(
            controller: _usernameController,
            // validator: (value) {
            //   if (value.isEmpty) return "Username can't be Empty";
            //   return null;
            // },
            style: TextStyle(
                color: firstColor,
                letterSpacing: 0.5,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            cursorColor: firstColor,
            decoration: InputDecoration(
                errorStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
                errorText: validate ? null : errText,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.person,
                    color: firstColor,
                  ),
                ),
                hintText: "Username",
                hintStyle: TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  emailTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 36),
      width: double.infinity,
      height: 68,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: secondColor,
        child: Container(
          alignment: Alignment.center,
          child: TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) return "Email cant't be empty";

              if (!value.contains("@")) return "Invalid Email";
            },
            style: TextStyle(
                color: firstColor,
                letterSpacing: 0.5,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            cursorColor: firstColor,
            decoration: InputDecoration(
                errorStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.mail,
                    color: firstColor,
                  ),
                ),
                hintText: "Email",
                hintStyle: TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  passwordTextField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 36),
      width: double.infinity,
      height: 68,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: secondColor,
        child: Container(
          alignment: Alignment.center,
          child: TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) return "Password cant't be empty";
              if (value.length < 8) return "Password is too Short";
            },
            style: TextStyle(
                color: firstColor,
                letterSpacing: 0.5,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            cursorColor: firstColor,
            obscureText: vis,
            decoration: InputDecoration(
                errorStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
                suffixIcon: IconButton(
                  color: firstColor,
                  icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      vis = !vis;
                    });
                  },
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.vpn_key,
                    color: firstColor,
                  ),
                ),
                hintText: "Password",
                hintStyle: TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
