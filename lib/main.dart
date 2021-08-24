import 'package:flutter/material.dart';

import 'package:memoapp/components/my_tab.dart';

void main() {
  runApp(const MemoApp());
}

class MemoApp extends StatelessWidget {
  const MemoApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyTab(),
    );
  }
}
