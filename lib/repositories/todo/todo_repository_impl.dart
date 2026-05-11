import '../../models/todo.dart';

import '../../services/todo/firebase_todo_service.dart';
import '../../services/todo/todo_service.dart';

import 'todo_repository.dart';

class TodoRepositoryImpl
    implements TodoRepository {

  final TodoService _service =
      FirebaseTodoService();

  @override
  Future<void> addTodo({
    required Todo todo,
  }) async {

    await _service.addTodo(
      todo: todo,
    );
  }

  @override
  Future<List<Todo>> getTodos({
    required String userId,
  }) async {

    return await _service.getTodos(
      userId: userId,
    );
  }

  @override
  Future<void> updateTodo({
    required Todo todo,
  }) async {

    await _service.updateTodo(
      todo: todo,
    );
  }

  @override
  Future<void> deleteTodo({
    required String id,
  }) async {

    await _service.deleteTodo(
      id: id,
    );
  }
}