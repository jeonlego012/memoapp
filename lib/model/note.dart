import 'package:cloud_firestore/cloud_firestore.dart';

typedef NotePressedCallback = void Function(String? noteId);

class Note {
  final String? id;
  final String title;
  final String content;
  final Timestamp creationTime;
  final DocumentReference? reference;

  Note({required this.title, required this.content, required this.creationTime})
      : id = null,
        reference = null;

  Note.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        title = snapshot['title'],
        content = snapshot['content'],
        creationTime = snapshot['creationTime'],
        reference = snapshot.reference;
}
