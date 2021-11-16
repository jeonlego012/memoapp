import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
              Text(
                diary.date.toDate().year.toString(),
                style: const TextStyle(color: Colors.grey, fontSize: 11.0),
              ),
              Text(
                diary.date.toDate().month.toString() + '월',
              ),
              Text(
                diary.date.toDate().day.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  color: colorWeekdayOrSaturdayOrSunday(diary.date),
                ),
              ),
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

Color colorWeekdayOrSaturdayOrSunday(Timestamp today) {
  DateTime todayDateTime = today.toDate();
  String dayOfWeek = DateFormat('EEEE').format(todayDateTime);
  Color dayColor;

  switch (dayOfWeek) {
    case 'Saturday':
      dayColor = Colors.blue;
      break;
    case 'Sunday':
      dayColor = Colors.red;
      break;
    default:
      dayColor = Colors.black;
      break;
  }

  return dayColor;
}
