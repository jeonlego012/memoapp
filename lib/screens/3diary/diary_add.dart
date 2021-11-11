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
  final _formKey = GlobalKey<FormState>(debugLabel: '_DiaryAddScreenState');
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime? diaryDate;

  @override
  Widget build(BuildContext context) {
    Widget bodySection = SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: [
              TextButton(
                child: const Text('날짜'),
                onPressed: () {
                  Future<DateTime?> selectedDate = showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2090),
                  );
                  selectedDate.then((dateTime) {
                    setState(() {
                      diaryDate = dateTime;
                      print("selected date is $diaryDate");
                    });
                  });
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: '제목',
                ),
              ),
              TextFormField(
                controller: _contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: '내용',
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () async {
            if (_formKey.currentState!.validate() &&
                _titleController.text != "") {
              addDiary(
                Diary(
                  title: _titleController.text,
                  content: _contentController.text,
                  date: Timestamp.fromDate(diaryDate!),
                ),
              );
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: bodySection,
    );
  }
}
