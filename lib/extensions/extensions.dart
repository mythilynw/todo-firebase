import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/todo.dart';
import '../models/todo.dart';


extension TodoRefExtension on WidgetRef {
  // WATCH 
  List<Todo> get todos => watch(todoProvider);

  // READ
  TodoViewModel get todoActions => read(todoProvider.notifier);
}