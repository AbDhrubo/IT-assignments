import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sembast_web/sembast_web.dart';

import '../models/notes.dart';
// Import your Note model

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;
  final _store = intMapStoreFactory.store('notes');

  // TODO: Initialize database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (kIsWeb) {
      // Use sembast_web for persistent web storage
      return await databaseFactoryWeb.openDatabase('notes.db');
    } else {
      final appDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDir.path, 'notes.db');
      return await databaseFactoryIo.openDatabase(dbPath);
    }
  }

  // TODO: Add a note
  Future<int> addNote(Note note) async {
    // Hint: Use _store.add()
    final db = await database;
    return await _store.add(db, note.toMap());
  }

  // TODO: Get all notes
  Future<List<Note>> getAllNotes() async {
    final db = await database;
    final records = await _store.find(db);
    return records.map((record) => Note.fromMap(record.value, record.key)).toList();
  }

  // TODO: Update a note
  Future<void> updateNote(Note note) async {
    // Hint: Use _store.record(note.id).update()
    final db = await database;
    await _store.record(note.id!).update(db, note.toMap());
  }

  // TODO: Delete a note
  Future<void> deleteNote(int id) async {
    // Hint: Use _store.record(id).delete()
    final db = await database;
    await _store.record(id).delete(db);
  }
}