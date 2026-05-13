import '../../models/todo.dart';

import '../../core/services/todo/todo_service.dart';

class TodoRepositoryImpl {

  final TodoService todoService;

  TodoRepositoryImpl({
    required this.todoService,
  });

  // ADD TODO

  Future<void> addTodo({
    required Todo todo,
  }) async {

    await todoService.addTodo(
      todo: todo,
    );
  }

  // GET TODOS

  Future<List<Todo>> getTodos({
    required String userId,
  }) async {

    return await todoService.getTodos(
      userId: userId,
    );
  }

  // UPDATE TODO

  Future<void> updateTodo({
    required Todo todo,
  }) async {

    await todoService.updateTodo(
      todo: todo,
    );
  }

  // DELETE TODO

  Future<void> deleteTodo({
    required String id,
  }) async {

    await todoService.deleteTodo(
      id: id,
    );
  }
}