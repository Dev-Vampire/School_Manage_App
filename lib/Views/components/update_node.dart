import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/Databases/note_table.dart';
import 'package:front_end_flutter/Databases/notedao.dart';
import 'package:front_end_flutter/constants.dart';
import 'package:get/get.dart';

class UpdateNote extends StatelessWidget {
  TextEditingController _title = TextEditingController();
  TextEditingController _message = TextEditingController();

  final NoteDao noteDao = Get.find();
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Note note = Get.arguments;
    _title.text = note.title;
    _message.text = note.message;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Note'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Please let your title";
                },
                controller: _title,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondColor)),
                    hintText: "Title",
                    hintStyle:
                        TextStyle(color: thirdColor, letterSpacing: 0.5)),
                style: TextStyle(
                    color: thirdColor, fontSize: 18, letterSpacing: 0.5),
                cursorColor: secondColor,
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: _message,
                validator: (value) {
                  if (value.isEmpty) return "Please let you description";
                },
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondColor)),
                    hintText: "Description",
                    hintStyle:
                        TextStyle(color: thirdColor, letterSpacing: 0.5)),
                style: TextStyle(
                    color: thirdColor, fontSize: 18, letterSpacing: 0.5),
                cursorColor: secondColor,
              ),
              SizedBox(height: 40),
              Container(
                width: size.width * 0.3,
                height: size.height * 0.054,
                child: RaisedButton(
                  color: secondColor,
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: firstColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      noteDao.updateNote(
                          Note(_title.text, _message.text, id: note.id));
                    }
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
