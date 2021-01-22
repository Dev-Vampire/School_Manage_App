import 'package:front_end_flutter/Databases/notedao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'dart:async';
import 'note_table.dart';
part 'note_database.g.dart';

@Database(version: 1, entities: [Note])
abstract class NoteDatabase extends FloorDatabase {
  NoteDao get noteDao;
}

