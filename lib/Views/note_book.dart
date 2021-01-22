import 'package:flutter/material.dart';
import 'package:front_end_flutter/Databases/note_table.dart';
import 'package:front_end_flutter/Databases/notedao.dart';
import 'package:front_end_flutter/Pages/loading_page.dart';
import 'package:front_end_flutter/Views/components/update_node.dart';
import 'package:front_end_flutter/constants.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'components/add_note.dart';

class NoteBookView extends StatefulWidget {
  @override
  _NoteBookViewState createState() => _NoteBookViewState();
}

class _NoteBookViewState extends State<NoteBookView> {
  final NoteDao noteDao = Get.find();

  List<Note> notes = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: noteList(),
      floatingActionButton: Container(
        height: 45,
        margin: const EdgeInsets.only(bottom: 42),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'add',
              onPressed: () {
                Get.to(AddNote());
              },
              child: Icon(Icons.add, size: 30),
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              heroTag: 'delete',
              onPressed: () {
                showAlertDialog(context);
              },
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  noteList() {
    return StreamBuilder<List<Note>>(
      stream: noteDao.getAllNotes(),
      builder: (_, data) {
        if (data.hasData) {
          notes = data.data;
          return ListView.builder(
            itemCount: data.data.length,
            itemBuilder: (_, position) {
              return Slidable(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: firstColor,
                    child: ListTile(
                      title: Text(
                        data.data[position].title,
                        style: TextStyle(
                          color: secondColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      subtitle: Text(
                        data.data[position].message,
                        style: TextStyle(
                            color: thirdColor,
                            fontSize: 18,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: [
                  Container(
                    height: 60,
                    child: IconSlideAction(
                      caption: "Update",
                      color: Colors.indigo[900],
                      icon: Icons.edit,
                      onTap: () {
                        Get.to(UpdateNote(), arguments: data.data[position]);
                      },
                    ),
                  ),
                  Container(
                    height: 60,
                    child: IconSlideAction(
                      caption: "Delete",
                      color: Colors.pink,
                      icon: Icons.delete,
                      onTap: () {
                        noteDao.deleteNote(data.data[position]);
                        Get.back();
                      },
                    ),
                  ),
                ],
              );
            },
          );
        } else if (data.hasError) {
          return Text('Error');
        } else {
          return LoadingPage();
        }
      },
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(
            fontSize: 16,
            color: secondColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(
            fontSize: 16,
            color: secondColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5),
      ),
      onPressed: () {
        noteDao.deleteAllNotes(notes);
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: fourthColor,
      title: Text(
        "Hello Dear!",
        style: TextStyle(color: thirdColor, fontWeight: FontWeight.bold),
      ),
      content: Text(
        "Are you sure to delete all your notes?",
        style: TextStyle(color: thirdColor),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
