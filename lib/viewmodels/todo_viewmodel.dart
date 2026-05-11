// lib/viewmodels/todo_view_model.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';

import '../repositories/todo/todo_repository.dart';

import '../providers/todo_provider.dart';

final todoProvider =
    StateNotifierProvider<
      TodoViewModel,
      List<Todo>
    >((ref) {

      final repository =
          ref.read(
            todoRepositoryProvider,
          );

      return TodoViewModel(
        repository: repository,
      );
    });

class TodoViewModel
    extends StateNotifier<List<Todo>> {

  final TodoRepository _repository;

  TodoViewModel({
    required TodoRepository repository,
  })  : _repository = repository,
        super([]);

  // CURRENT USER ID
  String? get currentUserId {

    return FirebaseAuth
        .instance
        .currentUser
        ?.uid;
  }

  // LOAD TODOS
  Future<void> loadTodos({
    required String userId,
  }) async {

    final todos =
        await _repository.getTodos(
          userId: userId,
        );

    state = todos;
  }

  // ADD TODO
  Future<void> addTodo({
    required Todo todo,
  }) async {

    await _repository.addTodo(
      todo: todo,
    );

    state = [
      todo,
      ...state,
    ];
  }

  // UPDATE TODO
  Future<void> updateTodo({
    required Todo todo,
  }) async {

    await _repository.updateTodo(
      todo: todo,
    );

    state = [
      for (final t in state)
        if (t.id == todo.id)
          todo
        else
          t,
    ];
  }

  // DELETE TODO
  Future<void> deleteTodo({
    required String id,
  }) async {

    await _repository.deleteTodo(
      id: id,
    );

    state = state
        .where((todo) {

          return todo.id != id;

        })
        .toList();
  }
}