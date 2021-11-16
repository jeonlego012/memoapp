import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:memoapp/model/todo.dart';
import 'package:memoapp/model/todo_transaction.dart';

class ChildTodo extends StatefulWidget {
  ChildTodo({
    Key? key,
    String? todoId,
  })  : _todoId = todoId!,
        super(key: key);

  final String _todoId;

  @override
  State<ChildTodo> createState() => _ChildTodoState();
}

class _ChildTodoState extends State<ChildTodo> {
  Todo? _todo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Todo>(
        future: getTodo(widget._todoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.hasData == false) {
            return const Center();
          }
          _todo = snapshot.data;
          final _contentController =
              TextEditingController(text: _todo!.content);
          final _dueDate = _todo!.dueDate.toDate();
          int dDay = calculateDday(_dueDate);
          bool? isChecked = _todo!.complete;
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Dismissible(
              background: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20.0),
                color: Colors.red,
                child: const Icon(Icons.delete),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                color: Colors.red,
                child: const Icon(Icons.delete),
              ),
              key: Key(widget._todoId),
              onDismissed: (direction) {
                deleteTodo(widget._todoId);
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('삭제됨!')));
              },
              child: CheckboxListTile(
                  activeColor: Colors.green.withOpacity(0.8),
                  title: TextField(
                      controller: _contentController,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      onEditingComplete: () async {
                        _todo!.content = _contentController.text;
                        await editTodoContent(
                            widget._todoId, _contentController.text);
                      }),
                  secondary: TextButton(
                    style: TextButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      Future<DateTime?> selectedDate = showDatePicker(
                        context: context,
                        initialDate: _todo!.dueDate.toDate(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2090),
                      );
                      selectedDate.then((dateTime) async {
                        await editTodoDueDate(
                            widget._todoId, Timestamp.fromDate(dateTime!));
                      }).onError((error, stack) {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (dDay == -2)
                          const Text('모레')
                        else if (dDay == -1)
                          const Text(
                            '내일',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        else if (dDay == 0)
                          const Text(
                            '오늘',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        else if (dDay > 0)
                          Text('D+$dDay')
                        else
                          Text('D$dDay'),
                        Text('~' +
                            DateFormat('MM/dd')
                                .format(_todo!.dueDate.toDate())),
                      ],
                    ),
                  ),
                  value: isChecked,
                  onChanged: (value) async {
                    await editTodoComplete(widget._todoId, value!);
                  }),
            ),
          );
        });
  }
}

int calculateDday(DateTime dueDate) {
  DateTime todayDateTime = DateTime.now();
  DateTime today = DateTime.utc(
      todayDateTime.year, todayDateTime.month, todayDateTime.day, -9, 0);
  int dDay = today.difference(dueDate).inDays;
  return dDay;
}
