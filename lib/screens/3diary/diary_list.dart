import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:memoapp/model/diary.dart';
import 'diary_add.dart';

class DiaryList extends StatefulWidget {
  const DiaryList({Key? key}) : super(key: key);

  @override
  State<DiaryList> createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {
  // StreamSubscription<QuerySnapshot>? _currentSubscription;
  // List<Diary> _diarys = <Diary>[];

  _DiaryListState() {
    //_currentSubscription =
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Icon(Icons.create),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiaryAddScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
