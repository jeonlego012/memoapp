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
  final _formKey = GlobalKey<FormState>(debugLabel: '_ChildTodoState');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Todo>(
        future: getTodo(widget._todoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.hasData == false) {
            return const Center();
          }
          final _contentController =
              TextEditingController(text: snapshot.data!.content);
          final duedate = snapshot.data!.dueDate.toDate();
          final today = DateTime.now();
          final dDay = today.difference(duedate).inDays;
          bool? isChecked = snapshot.data!.complete;
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
            child: CheckboxListTile(
                //////////////////////////////////
                title: Form(
                  key: _formKey,
                  child: TextFormField(
                      controller: _contentController,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      onEditingComplete: () async {
                        snapshot.data!.content = _contentController.text;
                        await editTodo(widget._todoId, _contentController.text,
                            snapshot.data!.dueDate, isChecked);
                      }),
                ),
                //////////////////////////////////
                secondary: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (dDay == -2)
                      Text('모레')
                    else if (dDay == -1)
                      Text('내일')
                    else if (dDay == 0)
                      Text('오늘')
                    else if (dDay > 0)
                      Text('D+$dDay')
                    else
                      Text('D$dDay'),
                    Text('~' +
                        DateFormat('MM/dd')
                            .format(snapshot.data!.dueDate.toDate())),
                  ],
                ),
                value: isChecked,
                onChanged: (value) {
                  //setState(() => isChecked = value);
                }),
          );
        });
  }
}
