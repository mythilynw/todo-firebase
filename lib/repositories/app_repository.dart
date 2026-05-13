import '../core/services/auth/auth_service.dart';
import '../core/services/auth/local_auth_service.dart';

import '../core/services/todo/todo_service.dart';
import '../core/services/todo/sqflite_todo_service.dart';

import '../services/todo/todo_repository_impl.dart';

class AppRepository {

  final AuthService auth =
      LocalAuthService();

  final TodoService todoService =
      SqfliteTodoService();

  late final TodoRepositoryImpl todo =
      TodoRepositoryImpl(
        todoService: todoService,
      );
}