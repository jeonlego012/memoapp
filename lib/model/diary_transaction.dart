import 'package:cloud_firestore/cloud_firestore.dart';
import 'diary.dart';

Future<void> addDiary(Diary diary) {
  final diarys = FirebaseFirestore.instance.collection('diarys');
  return diarys.add({
    'title': diary.title,
    'content': diary.content,
    'date': diary.date,
  });
}

Stream<QuerySnapshot> loadAllDiarys() {
  return FirebaseFirestore.instance
      .collection('diarys')
      .orderBy('date', descending: true)
      .snapshots();
}

List<Diary> getDiarysFromQuery(QuerySnapshot snapshot) {
  return snapshot.docs.map((DocumentSnapshot doc) {
    return Diary.fromSnapshot(doc);
  }).toList();
}

Future<Diary> getDiary(String diaryId) async {
  return FirebaseFirestore.instance
      .collection('diarys')
      .doc(diaryId)
      .get()
      .then((DocumentSnapshot doc) => Diary.fromSnapshot(doc));
}

Future<void> editDiary(
    String diaryId, String title, String content, Timestamp date) {
  final firebaseDiary =
      FirebaseFirestore.instance.collection('diarys').doc(diaryId);
  return firebaseDiary.update({
    'title': title,
    'content': content,
    'date': date,
  });
}

Future<void> deleteDiary(String diaryId) {
  final firebaseDiary =
      FirebaseFirestore.instance.collection('diarys').doc(diaryId);
  return firebaseDiary.delete();
}
