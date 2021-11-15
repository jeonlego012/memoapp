import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:memoapp/model/archive.dart';
import 'package:memoapp/model/archive_transaction.dart';

class ArchiveAddScreen extends StatefulWidget {
  @override
  _ArchiveAddScreenState createState() => _ArchiveAddScreenState();
}

class _ArchiveAddScreenState extends State<ArchiveAddScreen> {
  final _sayerController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget textSection = SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _sayerController,
            decoration: const InputDecoration(
              hintText: '화자',
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
            if (_contentController.text != "") {
              Timestamp createdTime = Timestamp.now();
              addArchive(
                Archive(
                  content: _contentController.text,
                  sayer: _sayerController.text,
                  creationTime: createdTime,
                ),
              );
            }
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: textSection,
    );
  }
}
