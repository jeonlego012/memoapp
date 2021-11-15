import 'package:cloud_firestore/cloud_firestore.dart';

class Archive {
  final String? id;
  String content;
  String? sayer;
  Timestamp creationTime;
  bool isFavorite;
  final DocumentReference? reference;

  Archive({
    required this.content,
    required this.sayer,
    required this.creationTime,
    required this.isFavorite,
  })  : id = null,
        reference = null;

  Archive.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        content = snapshot['content'],
        sayer = snapshot['sayer'],
        creationTime = snapshot['creationTime'],
        isFavorite = snapshot['isFavorite'],
        reference = snapshot.reference;
}
