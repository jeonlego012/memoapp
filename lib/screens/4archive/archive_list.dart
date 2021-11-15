import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:memoapp/model/archive.dart';
import 'package:memoapp/model/archive_transaction.dart';
import 'archive_add.dart';
import 'archive_child.dart';

class ArchiveList extends StatefulWidget {
  const ArchiveList({Key? key}) : super(key: key);

  @override
  State<ArchiveList> createState() => _ArchiveListState();
}

class _ArchiveListState extends State<ArchiveList> {
  StreamSubscription<QuerySnapshot>? _currentSubscription;
  List<Archive> _archives = <Archive>[];

  _ArchiveListState() {
    _currentSubscription = loadAllArchives().listen(_updateArchives);
  }

  void _updateArchives(QuerySnapshot snapshot) {
    setState(() {
      _archives = getArchivesFromQuery(snapshot);
    });
  }

  @override
  void dispose() {
    _currentSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget archiveBody = Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: _buildArchiveList(),
          ),
        ),
      ],
    );
    return Scaffold(
      body: archiveBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArchiveAddScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }

  List<ChildArchive> _buildArchiveList() {
    return _archives.map((archive) => ChildArchive(archive)).toList();
  }
}
