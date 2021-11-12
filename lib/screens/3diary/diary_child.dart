import 'package:flutter/material.dart';

import 'package:memoapp/model/diary.dart';
import 'diary_edit.dart';

class ChildDiary extends StatelessWidget {
  final Diary diary;

  ChildDiary(this.diary);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      child: ListTile(
          leading: Column(
            children: [
              Text(diary.date.toDate().year.toString(),
                  style: const TextStyle(color: Colors.grey, fontSize: 10.0)),
              Text(
                diary.date.toDate().month.toString() + '월',
              ),
              Text(diary.date.toDate().day.toString(),
                  style: const TextStyle(fontSize: 20.0)),
            ],
          ),
          title: Text(diary.title),
          subtitle: Text(
            diary.content,
            maxLines: 1,
            style: const TextStyle(fontSize: 13.0),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiaryEditScreen(diaryId: diary.id),
              ),
            );
          }),
    );
  }
}
