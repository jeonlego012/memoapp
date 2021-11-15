import 'package:flutter/material.dart';

import 'package:memoapp/model/archive.dart';
import 'package:memoapp/model/archive_transaction.dart';

class ArchiveEditScreen extends StatefulWidget {
  ArchiveEditScreen({
    Key? key,
    required String? archiveId,
  })  : _archiveId = archiveId!,
        super(key: key);

  final String _archiveId;
  @override
  _ArchiveEditScreenState createState() => _ArchiveEditScreenState();
}

class _ArchiveEditScreenState extends State<ArchiveEditScreen> {
  Archive? _archive;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Archive>(
        future: getArchive(widget._archiveId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.hasData == false) {
            return const Center();
          }
          _archive = snapshot.data;
          final _sayerController = TextEditingController(text: _archive!.sayer);
          final _contentController =
              TextEditingController(text: _archive!.content);
          Widget textSection = SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
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
                  editArchive(widget._archiveId, _sayerController.text,
                      _contentController.text);
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteArchive(widget._archiveId);
                      Navigator.pop(context);
                    })
              ],
              elevation: 0.0,
            ),
            body: textSection,
          );
        });
  }
}
