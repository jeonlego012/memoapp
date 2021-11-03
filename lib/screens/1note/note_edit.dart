import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:memoapp/model/note.dart';
import 'package:memoapp/model/note_transaction.dart';

class NoteEditScreen extends StatefulWidget {
  NoteEditScreen({
    Key? key,
    @required String? noteId,
  })  : _noteId = noteId!,
        super(key: key);

  final String _noteId;
  @override
  _NoteEditScreenState createState() => _NoteEditScreenState(noteId: _noteId);
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_NoteEditScreenState');

  Note? _note;
  bool _isLoading = true;

  _NoteEditScreenState({@required String? noteId}) {
    getNote(noteId!).then((Note note) {
      setState(() {
        _note = note;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _titleController =
        TextEditingController(text: _isLoading ? null : _note!.title);
    final _contentController =
        TextEditingController(text: _isLoading ? null : _note!.content);
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
            if (_formKey.currentState!.validate() &&
                _titleController.text != "") {
              Timestamp createdTime = Timestamp.now();
              editNote(
                widget._noteId,
                _titleController.text,
                _contentController.text,
                createdTime,
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
