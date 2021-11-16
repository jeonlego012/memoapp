import 'package:cloud_firestore/cloud_firestore.dart';

class Archive {
  final String? id;
  String content;
  String? sayer;
  Timestamp creationTime;
  final DocumentReference? reference;

  Archive({
    required this.content,
    required this.sayer,
    required this.creationTime,
  })  : id = null,
        reference = null;

  Archive.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        content = snapshot['content'],
        sayer = snapshot['sayer'],
        creationTime = snapshot['creationTime'],
        reference = snapshot.reference;
}
