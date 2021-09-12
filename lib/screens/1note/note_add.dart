import 'package:flutter/material.dart';

class NoteAddScreen extends StatefulWidget {
  @override
  _NoteAddScreenState createState() => _NoteAddScreenState();
}

class _NoteAddScreenState extends State<NoteAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note'),
      ),
    );
  }
}
