import 'package:flutter/material.dart';
import 'package:front_end_flutter/widgets/book.dart';


class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Book(),
    );
  }
}
