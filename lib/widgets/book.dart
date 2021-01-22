import 'package:flutter/material.dart';
import 'package:front_end_flutter/Views/note_book.dart';
import 'package:front_end_flutter/Views/old_question.dart';
import 'package:front_end_flutter/Views/textbook.dart';
import 'package:front_end_flutter/constants.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UCS - Kalay'),
        centerTitle: true,
        bottom: TabBar(
          labelColor: secondColor,
          labelStyle: TextStyle(fontSize: 20, letterSpacing: 0.5),
          controller: _tabController,
          indicatorColor: secondColor,
          unselectedLabelColor: Colors.grey[500],
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: EdgeInsets.all(0.0),
          tabs: [
            Tab(text: "TextBook"),
            Tab(text: "OldQuestion"),
            Tab(text: "Note")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [TextBookView(), OldQuestionView(), NoteBookView()],
      ),
    );
  }
}
