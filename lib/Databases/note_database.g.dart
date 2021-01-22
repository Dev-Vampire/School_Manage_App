// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorNoteDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NoteDatabaseBuilder databaseBuilder(String name) =>
      _$NoteDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NoteDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$NoteDatabaseBuilder(null);
}

class _$NoteDatabaseBuilder {
  _$NoteDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$NoteDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$NoteDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<NoteDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$NoteDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$NoteDatabase extends NoteDatabase {
  _$NoteDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao _noteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `message` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'note',
            (Note item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'message': item.message
                },
            changeListener),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'note',
            ['id'],
            (Note item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'message': item.message
                },
            changeListener),
        _noteDeletionAdapter = DeletionAdapter(
            database,
            'note',
            ['id'],
            (Note item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'message': item.message
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  final DeletionAdapter<Note> _noteDeletionAdapter;

  @override
  Stream<List<Note>> getAllNotes() {
    return _queryAdapter.queryListStream('select * from note',
        queryableName: 'note',
        isView: false,
        mapper: (Map<String, dynamic> row) => Note(
            row['title'] as String, row['message'] as String,
            id: row['id'] as int));
  }

  @override
  Future<void> addNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNote(Note note) async {
    await _noteUpdateAdapter.update(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNote(Note note) async {
    await _noteDeletionAdapter.delete(note);
  }

  @override
  Future<void> deleteAllNotes(List<Note> notes) async {
    await _noteDeletionAdapter.deleteList(notes);
  }
}
