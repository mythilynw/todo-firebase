import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import '../services/todo/todo_service_impl.dart';

final todoProvider =
    StateNotifierProvider<TodoViewModel, List<Todo>>((ref) {
  return TodoViewModel();
});
class TodoViewModel extends StateNotifier<List<Todo>> {
  TodoViewModel() : super([]);

  final TodoServiceImpl _service = TodoServiceImpl();

  // LOAD TODOS
  Future<void> loadTodos({required String userId}) async {
    final todos = await _service.getTodos(userId: userId);
    state = todos;
  }

  // ADD TODO
  Future<void> addTodo({required Todo todo}) async {
    await _service.addTodo(todo: todo);
    state = [...state, todo];
  }

  // UPDATE TODO
  Future<void> updateTodo({required Todo todo}) async {
    await _service.updateTodo(todo: todo);

    state = [
      for (final t in state)
        if (t.id == todo.id) todo else t,
    ];
  }

  //DELETE TODO
  Future<void> deleteTodo({required String id}) async {
    await _service.deleteTodo(id: id);

    state = state.where((t) => t.id != id).toList();
  }
}