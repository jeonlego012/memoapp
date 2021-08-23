import 'package:flutter/material.dart';

void main() {
  runApp(const MemoApp());
}

class MemoApp extends StatelessWidget {
  const MemoApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Note'),
                Tab(text: 'List'),
                Tab(text: 'Diary'),
                Tab(text: 'Archiv'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.create),
              Icon(Icons.create),
              Icon(Icons.create),
              Icon(Icons.create),
            ],
          ),
        ),
      ),
    );
  }
}
