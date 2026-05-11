import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/todo/todo_repository.dart';
import '../repositories/todo/todo_repository_impl.dart';

final todoRepositoryProvider =
    Provider<TodoRepository>((ref) {

  return TodoRepositoryImpl();

});