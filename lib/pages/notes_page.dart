import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_notes_app/components/drawer.dart';
import 'package:flutter_notes_app/components/note_tile.dart';
import 'package:flutter_notes_app/models/note.dart';
import 'package:flutter_notes_app/models/notes_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //text controller to access what the user types
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    readNotes();
  }

  //create a note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Center(
                child: Text(
                  'Create Note',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                ),
              ),
              content: TextField(
                controller: textController,
                decoration: InputDecoration(
                    hintText: 'New note...',
                    border: const UnderlineInputBorder(),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary))),
              ),
              actions: [
                //create button
                MaterialButton(
                  onPressed: () {
                    //add to database
                    context.read<NotesDatabase>().addNote(textController.text);

                    //clear the textfield
                    textController.clear();

                    //pop the dialog
                    Navigator.pop(context);
                  },
                  child: const Text('Create'),
                )
              ],
              actionsPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ));
  }

  //read notes
  void readNotes() {
    context.read<NotesDatabase>().fetchNotes();
  }

  //update note
  void updateNote(Note note) {
    //prefill the current note text
    note.text = textController.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Center(
                child: Text(
                  'Edit Note',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                ),
              ),
              content: TextField(
                controller: textController,
                decoration: InputDecoration(
                    hintText: 'New note...',
                    border: const UnderlineInputBorder(),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary))),
              ),
              actions: [
                //update button
                MaterialButton(
                  onPressed: () {
                    //updte note in database
                    context
                        .read<NotesDatabase>()
                        .updateNote(note.id, textController.text);

                    //clear the textfield
                    textController.clear();

                    //pop the dialog
                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                )
              ],
              actionsPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ));
  }

  //delete note
  void deleteNote(int id) {
    context.read<NotesDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    //access notes database
    final notesDatabase = context.watch<NotesDatabase>();

    //current notes
    List<Note> currentNotes = notesDatabase.currentNotes;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: createNote,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      drawer: const MyDrwer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),

          //list of notes
          Expanded(
            child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  //get indiviual note object
                  final noteItem = currentNotes[index];

                  //return list tile ui
                  return NoteTile(
                      text: noteItem.text,
                      onEditPressed: () => updateNote(noteItem),
                      onDeletePressed: () => deleteNote(noteItem.id));
                }),
          ),
        ],
      ),
    );
  }
}
