import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/notes.dart';
import '../services/database_service.dart';
// Import your DatabaseService and Note model

// Provider for DatabaseService
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

// Provider for the list of notes
final notesProvider = StateNotifierProvider<NotesNotifier, List<Note>>((ref) {
  return NotesNotifier(ref);
});

class NotesNotifier extends StateNotifier<List<Note>> {
  final Ref ref;

  NotesNotifier(this.ref) : super([]) {
    loadNotes(); // Load notes when created
  }

  // TODO: Load all notes
  Future<void> loadNotes() async {
    // Get database service
    // Get all notes
    // Update state
    final dbService = ref.read(databaseServiceProvider);
    final notes = await dbService.getAllNotes();
    state = notes;
  }

  // TODO: Add a note
  Future<void> addNote(String title, String content) async {
    // Create new note
    // Add to database
    // Reload notes
    final dbService = ref.read(databaseServiceProvider);
    final newNote = Note(title: title, content: content);
    await dbService.addNote(newNote);
    await loadNotes();
  }

  // TODO: Update a note
  Future<void> updateNote(Note note) async {
    // Update in database
    // Reload notes
    final dbService = ref.read(databaseServiceProvider);
    await dbService.updateNote(note);
    await loadNotes();
  }

  // TODO: Delete a note
  Future<void> deleteNote(int id) async {
    // Delete from database
    // Reload notes
    final dbService = ref.read(databaseServiceProvider);
    await dbService.deleteNote(id);
    await loadNotes();
  }
}