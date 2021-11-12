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
