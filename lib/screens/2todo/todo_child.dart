import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:memoapp/model/todo.dart';
import 'package:memoapp/model/todo_transaction.dart';

class ChildTodo extends StatefulWidget {
  ChildTodo({
    Key? key,
    @required String? todoId,
  })  : _todoId = todoId!,
        super(key: key);

  final String _todoId;

  @override
  State<ChildTodo> createState() => _ChildTodoState(todoId: _todoId);
}

class _ChildTodoState extends State<ChildTodo> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_ChildTodoState');

  Todo? _todo;
  String? _todoId;

  _ChildTodoState({@required String? todoId}) {
    getTodo(todoId!).then((Todo todo) {
      setState(() {
        _todo = todo;
        _todoId = todoId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _contentController = TextEditingController(text: _todo!.content);

    final duedate = _todo?.dueDate.toDate();
    final today = DateTime.now();
    final dDay = today.difference(duedate!).inDays;
    bool? isChecked = _todo?.complete;

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
                decoration: const InputDecoration(border: InputBorder.none),
                onEditingComplete: () async {
                  _todo!.content = _contentController.text;
                  await editTodo(widget._todoId, _contentController.text,
                      _todo?.dueDate, isChecked);
                  await getTodo(_todoId!).then((Todo todo) {
                    setState(() {
                      _todo = todo;
                    });
                  });
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
              Text('~' + DateFormat('MM/dd').format(_todo!.dueDate.toDate())),
            ],
          ),
          value: isChecked,
          onChanged: (value) {
            setState(() => isChecked = value);
          }),
    );
  }
}
