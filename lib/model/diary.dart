import 'package:cloud_firestore/cloud_firestore.dart';

class Diary {
  final String? id;
  final String title;
  final String content;
  final Timestamp date;
  final DocumentReference? reference;

  Diary({required this.title, required this.content, required this.date})
      : id = null,
        reference = null;

  Diary.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        title = snapshot['title'],
        content = snapshot['content'],
        date = snapshot['date'],
        reference = snapshot.reference;
}
