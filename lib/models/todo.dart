library todo;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';
import 'todo_status.dart';

part 'todo.g.dart';

abstract class Todo implements Built<Todo, TodoBuilder> {
  String get id;
  String get title;
  String get description;
  String get userId;
  int get createdAt;
  TodoStatus get status; 

  Todo._();

  factory Todo([void Function(TodoBuilder) updates]) = _$Todo;

  static Serializer<Todo> get serializer => _$todoSerializer;

  // JSON → Object
  static Todo fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Todo.serializer, json)!;
  }

  // Object → JSON
  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Todo.serializer, this)
        as Map<String, dynamic>;
  }
}