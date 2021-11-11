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
