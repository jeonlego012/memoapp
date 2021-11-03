import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'note.dart';

Future<void> addNote(Note note) {
  final notes = FirebaseFirestore.instance.collection('notes');
  return notes.add({
    'title': note.title,
    'content': note.content,
    'creationTime': note.creationTime,
  });
}

Stream<QuerySnapshot> loadAllNotes() {
  return FirebaseFirestore.instance
      .collection('notes')
      .orderBy('creationTime', descending: true)
      .snapshots();
}

List<Note> getNotesFromQuery(QuerySnapshot snapshot) {
  return snapshot.docs.map((DocumentSnapshot doc) {
    return Note.fromSnapshot(doc);
  }).toList();
}

Future<Note> getNote(String noteId) async {
  return FirebaseFirestore.instance
      .collection('notes')
      .doc(noteId)
      .get()
      .then((DocumentSnapshot doc) => Note.fromSnapshot(doc));
}

Future<void> editNote(
    String noteId, String title, String content, Timestamp newTime) {
  final firebase_note =
      FirebaseFirestore.instance.collection('notes').doc(noteId);
  return firebase_note.update({
    'title': title,
    'content': content,
    'creationTime': newTime,
  });
}

Future<void> deleteNote(String noteId) async {
  final firebase_note =
      FirebaseFirestore.instance.collection('notes').doc(noteId);
  firebase_note.delete();
}
