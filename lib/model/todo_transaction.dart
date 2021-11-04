import 'package:cloud_firestore/cloud_firestore.dart';
import 'todo.dart';

Future<void> addTodo(Todo todo) {
  final todos = FirebaseFirestore.instance.collection('todos');
  return todos.add({
    'content': todo.content,
    'dueDate': todo.dueDate,
    'complete': todo.complete,
  });
}

Stream<QuerySnapshot> loadAllTodos() {
  return FirebaseFirestore.instance
      .collection('todos')
      .orderBy('dueDate')
      .snapshots();
}

List<Todo> getTodosFromQuery(QuerySnapshot snapshot) {
  return snapshot.docs.map((DocumentSnapshot doc) {
    return Todo.fromSnapshot(doc);
  }).toList();
}

Future<Todo> getTodo(String todoId) async {
  return FirebaseFirestore.instance
      .collection('todos')
      .doc(todoId)
      .get()
      .then((DocumentSnapshot doc) => Todo.fromSnapshot(doc));
}

Future<void> editTodo(
    String todoId, String content, Timestamp? newTime, bool? complete) {
  final firebaseTodo =
      FirebaseFirestore.instance.collection('todos').doc(todoId);
  return firebaseTodo.update({
    'content': content,
    'dueDate': newTime,
    'complete': complete,
  });
}
