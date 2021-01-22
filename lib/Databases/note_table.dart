import 'package:floor/floor.dart';

@Entity(tableName: 'note')
class Note {
  @PrimaryKey(autoGenerate: true)
  int id;

  @ColumnInfo(name: 'title')
  String title;
  String message;
  Note(this.title, this.message, {this.id});
}
