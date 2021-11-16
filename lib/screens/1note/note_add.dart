import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:memoapp/model/note.dart';
import 'package:memoapp/model/note_transaction.dart';

class NoteAddScreen extends StatefulWidget {
  @override
  _NoteAddScreenState createState() => _NoteAddScreenState();
}

class _NoteAddScreenState extends State<NoteAddScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget textSection = SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: '제목',
            ),
          ),
          TextField(
            controller: _contentController,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: '내용',
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () async {
            if (_titleController.text != "") {
              Timestamp createdTime = Timestamp.now();
              addNote(
                Note(
                  title: _titleController.text,
                  content: _contentController.text,
                  creationTime: createdTime,
                ),
              );
            }
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: textSection,
    );
  }
}
