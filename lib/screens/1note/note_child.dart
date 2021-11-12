import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:memoapp/model/note.dart';
import 'package:memoapp/model/note_transaction.dart';
import 'note_edit.dart';

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
      child: Dismissible(
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20.0),
          color: Colors.red,
          child: const Icon(Icons.delete),
        ),
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
          color: Colors.red,
          child: const Icon(Icons.delete),
        ),
        key: Key(note.id!),
        onDismissed: (direction) {
          deleteNote(note.id!);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('삭제됨!')));
        },
        child: ListTile(
          title: Text(
            note.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            note.content,
            maxLines: 3,
          ),
          trailing: Text(
            DateFormat('yyyy. MM. dd').format(note.creationTime.toDate()),
            style: const TextStyle(
              fontSize: 11.0,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteEditScreen(noteId: note.id),
              ),
            );
          },
        ),
      ),
    );
  }
}
