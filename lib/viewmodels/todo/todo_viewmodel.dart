import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/todo.dart';
import '../../models/todo_status.dart';

import '../../repositories/app_repository.dart';

final appRepositoryProvider =
    Provider<AppRepository>((ref) {

  return AppRepository();
});

final todoProvider =
    StateNotifierProvider<
        TodoViewModel,
        List<Todo>>((ref) {

  return TodoViewModel(
    appRepository:
        ref.read(
          appRepositoryProvider,
        ),
  );
});

class TodoViewModel
    extends StateNotifier<List<Todo>> {

  final AppRepository
      appRepository;

  TodoViewModel({
    required this.appRepository,
  }) : super([]) {

    loadTodos();
  }

  String? get currentUserId =>
      'demo-user';

  // LOAD TODOS

  Future<void> loadTodos() async {

    state =
        await appRepository.todo
            .getTodos(
      userId: currentUserId!,
    );
  }

  // ADD TODO

  Future<void> addTodo({
    required Todo todo,
  }) async {

    await appRepository.todo
        .addTodo(
      todo: todo,
    );

    await loadTodos();
  }

  // DELETE TODO

  Future<void> deleteTodo({
    required String id,
  }) async {

    await appRepository.todo
        .deleteTodo(
      id: id,
    );

    await loadTodos();
  }

  // UPDATE TODO

  Future<void> updateTodo({
    required Todo todo,
  }) async {

    await appRepository.todo
        .updateTodo(
      todo: todo,
    );

    await loadTodos();
  }

  // UPDATE STATUS

  Future<void> updateTodoStatus({
    required Todo todo,
    required TodoStatus status,
  }) async {

    final updatedTodo =
        todo.rebuild(
      (builder) =>
          builder.status = status,
    );

    await updateTodo(
      todo: updatedTodo,
    );
  }
}