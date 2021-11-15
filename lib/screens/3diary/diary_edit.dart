import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:memoapp/model/diary.dart';
import 'package:memoapp/model/diary_transaction.dart';

class DiaryEditScreen extends StatefulWidget {
  DiaryEditScreen({
    Key? key,
    @required String? diaryId,
  })  : _diaryId = diaryId!,
        super(key: key);

  final String _diaryId;

  _DiaryEditScreenState createState() => _DiaryEditScreenState();
}

class _DiaryEditScreenState extends State<DiaryEditScreen> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_DiaryEditScreenState');

  Diary? _diary;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Diary>(
        future: getDiary(widget._diaryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.hasData == false) {
            return const Center();
          }
          _diary = snapshot.data;
          final _titleController = TextEditingController(text: _diary!.title);
          final _contentController =
              TextEditingController(text: _diary!.content);
          DateTime? editedDate = _diary!.date.toDate();
          Widget bodySection = SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(primary: Colors.black),
                        icon: const Icon(Icons.date_range),
                        label: const Text("날짜 선택"),
                        onPressed: () async {
                          Future<DateTime?> selectedDate = showDatePicker(
                            context: context,
                            initialDate: _diary!.date.toDate(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2090),
                          );
                          selectedDate.then((dateTime) {
                            setState(() {
                              editedDate = dateTime;
                              editDiaryDate(widget._diaryId,
                                  Timestamp.fromDate(editedDate!));
                            });
                          }).onError((error, stack) {});
                        },
                      ),
                      Text(DateFormat('yyyy년 MM월 dd일').format(editedDate!)),
                    ],
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
          );
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _titleController.text != "") {
                    editDiary(
                      widget._diaryId,
                      _titleController.text,
                      _contentController.text,
                    );
                  }
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteDiary(widget._diaryId);
                      Navigator.pop(context);
                    }),
              ],
              elevation: 0.0,
            ),
            body: bodySection,
          );
        });
  }
}
