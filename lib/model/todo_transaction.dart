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
      .orderBy('complete')
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

Future<void> editTodoContent(String todoId, String newContent) {
  final firebaseTodo =
      FirebaseFirestore.instance.collection('todos').doc(todoId);
  return firebaseTodo.update({
    'content': newContent,
  });
}

Future<void> editTodoDueDate(String todoId, Timestamp newTime) {
  final firebaseTodo =
      FirebaseFirestore.instance.collection('todos').doc(todoId);
  return firebaseTodo.update({
    'dueDate': newTime,
  });
}

Future<void> editTodoComplete(String todoId, bool newComplete) {
  final firebaseTodo =
      FirebaseFirestore.instance.collection('todos').doc(todoId);
  return firebaseTodo.update({
    'complete': newComplete,
  });
}

Future<void> deleteTodo(String todoId) {
  final firebaseTodo =
      FirebaseFirestore.instance.collection('todos').doc(todoId);
  return firebaseTodo.delete();
}
