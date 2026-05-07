library user;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  String get uid;
  String get name;
  String get email;
  int get createdAt;

  User._();

  factory User([void Function(UserBuilder) updates]) = _$User;

  static Serializer<User> get serializer => _$userSerializer;

  static User fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(User.serializer, json)!;
  }

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(User.serializer, this)
        as Map<String, dynamic>;
  }
}