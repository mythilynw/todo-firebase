import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/todo.dart';

import '../todo/todo_service.dart';

class FirebaseTodoService
    implements TodoService {

  final FirebaseFirestore
      _firestore =
          FirebaseFirestore.instance;

  @override
  Future<void> addTodo({
    required Todo todo,
  }) async {

    await _firestore
        .collection('todos')
        .doc(todo.id)
        .set(
          todo.toJson(),
        );
  }

  @override
  Future<List<Todo>> getTodos({
    required String userId,
  }) async {

    final snapshot =
        await _firestore
            .collection('todos')
            .where(
              'userId',
              isEqualTo: userId,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) => Todo.fromJson(
            doc.data(),
          ),
        )
        .toList();
  }

  @override
  Future<void> updateTodo({
    required Todo todo,
  }) async {

    await _firestore
        .collection('todos')
        .doc(todo.id)
        .update(
          todo.toJson(),
        );
  }

  @override
  Future<void> deleteTodo({
    required String id,
  }) async {

    await _firestore
        .collection('todos')
        .doc(id)
        .delete();
  }
}