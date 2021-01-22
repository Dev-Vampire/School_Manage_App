import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_end_flutter/Pages/loading_page.dart';
import 'package:front_end_flutter/Screens/welcome/welcome_screen.dart';
import 'package:front_end_flutter/constants.dart';
import 'package:front_end_flutter/widgets/bottom_nav.dart';
import 'package:get/get.dart';

import 'Databases/note_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = LoadingPage();

  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String token = await storage.read(key: 'token');
    if (token != null) {
      setState(() {
        page = BottomNav();
      });
    } else {
      setState(() {
        page = WelcomeScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Management App',
      theme: ThemeData(
        primaryColor: firstColor,
        accentColor: secondColor,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: FutureBuilder<NoteDatabase>(
        future: $FloorNoteDatabase.databaseBuilder('note.db').build(),
        builder: (context, data) {
          if (data.hasData) {
            Get.put(data.data.noteDao);
            return page;
          } else if (data.hasError) {
            return Text("Error");
          } else {
            return LoadingPage();
          }
        },
      ),
    );
  }
}
