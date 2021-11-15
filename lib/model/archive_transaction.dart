import 'package:cloud_firestore/cloud_firestore.dart';
import 'archive.dart';

Future<void> addArchive(Archive archive) {
  final archives = FirebaseFirestore.instance.collection('archives');
  return archives.add({
    'content': archive.content,
    'sayer': archive.sayer,
    'creationTime': archive.creationTime,
  });
}
