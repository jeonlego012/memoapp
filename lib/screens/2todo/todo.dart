import 'package:flutter/material.dart';

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Icon(Icons.create),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
