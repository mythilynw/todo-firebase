// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TodoStatus _$pending = const TodoStatus._('pending');
const TodoStatus _$inProgress = const TodoStatus._('inProgress');
const TodoStatus _$completed = const TodoStatus._('completed');

TodoStatus _$valueOf(String name) {
  switch (name) {
    case 'pending':
      return _$pending;
    case 'inProgress':
      return _$inProgress;
    case 'completed':
      return _$completed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TodoStatus> _$values = BuiltSet<TodoStatus>(const <TodoStatus>[
  _$pending,
  _$inProgress,
  _$completed,
]);

Serializer<TodoStatus> _$todoStatusSerializer = _$TodoStatusSerializer();

class _$TodoStatusSerializer implements PrimitiveSerializer<TodoStatus> {
  @override
  final Iterable<Type> types = const <Type>[TodoStatus];
  @override
  final String wireName = 'TodoStatus';

  @override
  Object serialize(
    Serializers serializers,
    TodoStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) => object.name;

  @override
  TodoStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TodoStatus.valueOf(serialized as String);
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
