import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String? id;
  String content;
  Timestamp dueDate;
  bool complete;
  final DocumentReference? reference;

  Todo({required this.content, required this.dueDate, required this.complete})
      : id = null,
        reference = null;

  Todo.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        content = snapshot['content'],
        dueDate = snapshot['dueDate'],
        complete = snapshot['complete'],
        reference = snapshot.reference;
}
