import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';

import '../providers/auth_provider.dart';

import '../viewmodels/auth/auth_viewmodel.dart';
import '../viewmodels/todo_viewmodel.dart';

extension RefExtension on WidgetRef {

  //  AUTH 

  // WATCH 
  bool get authLoading =>
      watch(authViewModelProvider);

  // READ 
  AuthViewModel get authActions =>
      read(authViewModelProvider.notifier);

  // TODO 

  // WATCH 
  List<Todo> get todos =>
      watch(todoProvider);

  // READ 
  TodoViewModel get todoActions =>
      read(todoProvider.notifier);
}