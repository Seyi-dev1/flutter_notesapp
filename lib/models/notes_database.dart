import 'package:flutter/material.dart';
import 'package:flutter_notes_app/models/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NotesDatabase extends ChangeNotifier {
  static late Isar isar;
  //INITIALIZE DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  //list of notes
  final List<Note> currentNotes = [];

  //CREATE - a new note
  Future<void> addNote(String textFromUser) async {
    //create new note object
    final newNote = Note()..text = textFromUser;

    //save to database
    await isar.writeTxn(() => isar.notes.put(newNote));

    //re-read from database
    await fetchNotes();
  }

  //READ - notes from database
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes =
        await isar.writeTxn(() => isar.notes.where().findAll());
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  //UPDATE - update a note in the database
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);

    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  //DELETE - delete a note from the database
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
