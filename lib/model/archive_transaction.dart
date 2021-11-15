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

Stream<QuerySnapshot> loadAllArchives() {
  return FirebaseFirestore.instance
      .collection('archives')
      .orderBy('order', descending: true)
      .snapshots();
}

List<Archive> getArchivesFromQuery(QuerySnapshot snapshot) {
  return snapshot.docs.map((DocumentSnapshot doc) {
    return Archive.fromSnapshot(doc);
  }).toList();
}

Future<Archive> getArchive(String archiveId) async {
  return FirebaseFirestore.instance
      .collection('archives')
      .doc(archiveId)
      .get()
      .then((DocumentSnapshot doc) => Archive.fromSnapshot(doc));
}

Future<void> editArchive(String archiveId, String sayer, String content) {
  final firebaseArchive =
      FirebaseFirestore.instance.collection('archives').doc(archiveId);
  return firebaseArchive.update({
    'content': content,
    'sayer': sayer,
  });
}

Future<void> deleteArchive(String archiveId) {
  final firebaseArchive =
      FirebaseFirestore.instance.collection('archives').doc(archiveId);
  return firebaseArchive.delete();
}
