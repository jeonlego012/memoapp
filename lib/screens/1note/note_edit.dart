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
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_NoteEditScreenState');

  Note? _note;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Note>(
        future: getNote(widget._noteId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.hasData == false) {
            return const Center();
          }
          _note = snapshot.data;
          final _titleController = TextEditingController(text: _note!.title);
          final _contentController =
              TextEditingController(text: _note!.content);
          Widget textSection = SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
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
                  ),
                ],
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
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteNote(widget._noteId);
                    Navigator.pop(context);
                  },
                ),
              ],
              elevation: 0.0,
            ),
            body: textSection,
          );
        });
  }
}
