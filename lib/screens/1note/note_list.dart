import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:memoapp/model/note.dart';
import 'package:memoapp/model/note_transaction.dart';
import 'note_add.dart';
import 'note_edit.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  StreamSubscription<QuerySnapshot>? _currentSubscription;
  List<Note> _notes = <Note>[];

  _NoteListState() {
    _currentSubscription = loadAllNotes().listen(_updateNotes);
  }

  @override
  void dispose() {
    _currentSubscription?.cancel();
    super.dispose();
  }

  void _updateNotes(QuerySnapshot snapshot) {
    setState(() {
      _notes = getNotesFromQuery(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget noteBody = Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: _buildNoteList(),
          ),
        ),
      ],
    );
    return Scaffold(
      body: noteBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteAddScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }

  List<ChildNote> _buildNoteList() {
    return _notes.map((contact) => ChildNote(contact)).toList();
  }
}

class ChildNote extends StatelessWidget {
  final Note note;

  ChildNote(this.note);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      child: ListTile(
        trailing: Text(
            DateFormat('yyyy년 MM월 dd일').format(note.creationTime.toDate())),
        title: Text(note.title),
        subtitle: Text(note.content),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditScreen(noteId: note.id),
            ),
          );
        },
      ),
    );
  }
}
