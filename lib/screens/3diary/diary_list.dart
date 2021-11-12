import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:memoapp/model/diary.dart';
import 'package:memoapp/model/diary_transaction.dart';
import 'diary_add.dart';
import 'diary_child.dart';

class DiaryList extends StatefulWidget {
  const DiaryList({Key? key}) : super(key: key);

  @override
  State<DiaryList> createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {
  StreamSubscription<QuerySnapshot>? _currentSubscription;
  List<Diary> _diarys = <Diary>[];

  _DiaryListState() {
    _currentSubscription = loadAllDiarys().listen(_updateDiarys);
  }

  @override
  void dispose() {
    _currentSubscription!.cancel();
    super.dispose();
  }

  void _updateDiarys(QuerySnapshot snapshot) {
    setState(() {
      _diarys = getDiarysFromQuery(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget diaryBody = Column(children: [
      Expanded(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: _buildDiaryList(),
        ),
      ),
    ]);
    return Scaffold(
      body: diaryBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiaryAddScreen()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  List<ChildDiary> _buildDiaryList() {
    return _diarys.map((diary) => ChildDiary(diary)).toList();
  }
}
