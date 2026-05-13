import '../../../models/todo.dart';

abstract class TodoService {

  Future<void> addTodo({
    required Todo todo,
  });

  Future<List<Todo>> getTodos({
    required String userId,
  });

  Future<void> updateTodo({
    required Todo todo,
  });

  Future<void> deleteTodo({
    required String id,
  });
}