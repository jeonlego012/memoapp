import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:memoapp/model/diary.dart';
import 'package:memoapp/model/diary_transaction.dart';

class DiaryAddScreen extends StatefulWidget {
  @override
  _DiaryAddScreenState createState() => _DiaryAddScreenState();
}

class _DiaryAddScreenState extends State<DiaryAddScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime diaryDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Widget bodySection = SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                icon: const Icon(Icons.date_range),
                label: const Text("날짜 선택"),
                onPressed: () {
                  Future<DateTime?> selectedDate = showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2090),
                  );
                  selectedDate.then((dateTime) {
                    setState(() {
                      diaryDate = dateTime!;
                    });
                  }).onError((error, stack) {});
                },
              ),
              Text(DateFormat('yyyy년 MM월 dd일').format(diaryDate)),
            ],
          ),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: '제목',
            ),
          ),
          TextField(
            controller: _contentController,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: '내용',
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () async {
            if (_titleController.text != "") {
              addDiary(
                Diary(
                  title: _titleController.text,
                  content: _contentController.text,
                  date: Timestamp.fromDate(diaryDate),
                ),
              );
            }
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: bodySection,
    );
  }
}
