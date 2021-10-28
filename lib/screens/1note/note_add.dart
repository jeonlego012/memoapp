import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:memoapp/model/note.dart';
import 'package:memoapp/model/note_transaction.dart';

class NoteAddScreen extends StatefulWidget {
  @override
  _NoteAddScreenState createState() => _NoteAddScreenState();
}

class _NoteAddScreenState extends State<NoteAddScreen> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_NoteAddScreenState');
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget textSection = SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: '제목',
                ),
                //validator:
              ),
              TextFormField(
                controller: _contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: '내용',
                  border: InputBorder.none,
                ),
                //validator:
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Timestamp createdTime = Timestamp.now();
              addNote(
                Note(
                  title: _titleController.text,
                  content: _contentController.text,
                  creationTime: createdTime,
                ),
              );
              Navigator.pop(context);
            }
          },
        ),
        elevation: 0.0,
      ),
      body: textSection,
    );
  }
}
