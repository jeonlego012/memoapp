import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:memoapp/model/note.dart';
import 'package:memoapp/model/note_transaction.dart';
import 'package:memoapp/components/search_box.dart';
import 'note_add.dart';
import 'note_child.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  StreamSubscription<QuerySnapshot>? _currentSubscription;
  List<Note> _notes = <Note>[];
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  _NoteListState() {
    _currentSubscription = loadAllNotes().listen(_updateNotes);
    _searchController.addListener(() {
      setState(() {
        if (_searchController.text.isEmpty) {
          _searchText = "";
        } else {
          _searchText = _searchController.text;
        }
      });
    });
  }

  @override
  void dispose() {
    _currentSubscription!.cancel();
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
        searchBox(_searchController, Colors.orange),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: _buildNoteList(),
          ),
        ),
      ],
    );
    return Scaffold(
      body: noteBody,
      floatingActionButton: FloatingActionButton(
        heroTag: const Text('note'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteAddScreen()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }

  List<ChildNote> _buildNoteList() {
    if (_searchText.isEmpty) {
      return _notes.map((note) => ChildNote(note)).toList();
    } else {
      List<Note> _searchNote = [];
      String _title, _content;
      for (int i = 0; i < _notes.length; i++) {
        _title = _notes.elementAt(i).title;
        _content = _notes.elementAt(i).content;
        if (_title.toLowerCase().contains(_searchText.toLowerCase()) ||
            _content.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchNote.add(_notes.elementAt(i));
        }
      }
      return _searchNote.map((note) => ChildNote(note)).toList();
    }
  }
}
