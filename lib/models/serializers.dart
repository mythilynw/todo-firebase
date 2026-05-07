library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'user.dart';
import 'todo.dart';
import 'todo_status.dart';

part 'serializers.g.dart';

@SerializersFor([
  User,
  Todo,
  TodoStatus,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();