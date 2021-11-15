import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:memoapp/model/diary.dart';
import 'package:memoapp/model/diary_transaction.dart';
import 'package:memoapp/components/search_box.dart';
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
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  _DiaryListState() {
    _currentSubscription = loadAllDiarys().listen(_updateDiarys);
    _searchController.addListener(() {
      setState(() {
        if (_searchController.text.isEmpty) {
          _searchText = "";
        } else {
          _searchText = _searchController.text;
        }
      });
    });
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
    Widget diaryBody = Column(
      children: [
        searchBox(_searchController, Colors.blue),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: _buildDiaryList(),
          ),
        ),
      ],
    );
    return Scaffold(
      body: diaryBody,
      floatingActionButton: FloatingActionButton(
        heroTag: const Text('diary'),
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
    if (_searchText.isEmpty) {
      return _diarys.map((diary) => ChildDiary(diary)).toList();
    } else {
      List<Diary> _searchDiary = [];
      String _title, _content;
      for (int i = 0; i < _diarys.length; i++) {
        _title = _diarys.elementAt(i).title;
        _content = _diarys.elementAt(i).content;
        if (_title.toLowerCase().contains(_searchText.toLowerCase()) ||
            _content.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchDiary.add(_diarys.elementAt(i));
        }
      }
      return _searchDiary.map((diary) => ChildDiary(diary)).toList();
    }
  }
}
