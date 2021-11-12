import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:memoapp/model/todo.dart';
import 'package:memoapp/model/todo_transaction.dart';
import 'todo_child.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  StreamSubscription<QuerySnapshot>? _currentSubscription;
  List<Todo> _todos = <Todo>[];

  _TodoListState() {
    _currentSubscription = loadAllTodos().listen(_updateTodos);
  }

  @override
  void dispose() {
    _currentSubscription?.cancel();
    super.dispose();
  }

  void _updateTodos(QuerySnapshot snapshot) {
    setState(() {
      _todos = getTodosFromQuery(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget todoBody = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(calculateTodayDate(),
              style: const TextStyle(
                fontSize: 30,
              )),
        ),
        Expanded(
          child: ListView(
            children: _buildTodoList(),
          ),
        ),
      ],
    );
    return Scaffold(
      body: todoBody,
      floatingActionButton: FloatingActionButton(
        heroTag: const Text('todo'),
        onPressed: () {
          DateTime todayDateTime = DateTime.now();
          Timestamp todayTimestamp = Timestamp.fromDate(DateTime.utc(
              todayDateTime.year,
              todayDateTime.month,
              todayDateTime.day,
              -9,
              0));
          addTodo(
            Todo(
              content: "",
              dueDate: todayTimestamp,
              complete: false,
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  List<ChildTodo> _buildTodoList() {
    return _todos.map((_todo) => ChildTodo(todoId: _todo.id!)).toList();
  }
}

String calculateTodayDate() {
  DateTime todayDateTime = DateTime.now();
  String todayString =
      DateFormat('yyyy년 MM월 dd일 EEEE', 'ko').format(todayDateTime);

  return todayString;
}
