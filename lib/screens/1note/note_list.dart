import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:memoapp/model/note.dart';
import 'package:memoapp/model/note_transaction.dart';
import 'note_add.dart';

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
    return ListTile(
      //leading: Text(this.note.creationTime.toDate().toString()),
      title: Text(this.note.title),
      subtitle: Text(this.note.content),
      //"${DateFormat('yyyy년 MM월 dd일 kk시mm분').format(this.note.creationTime.toDate())}"),
      //onTap:
    );
  }
}
