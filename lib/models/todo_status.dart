library todo_status;
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'todo_status.g.dart';

class TodoStatus extends EnumClass {
  static const TodoStatus pending = _$pending;
  static const TodoStatus inProgress = _$inProgress;
  static const TodoStatus completed = _$completed;

  const TodoStatus._(String name) : super(name);

  static BuiltSet<TodoStatus> get values => _$values;
  static TodoStatus valueOf(String name) => _$valueOf(name);

  static Serializer<TodoStatus> get serializer => _$todoStatusSerializer;
}