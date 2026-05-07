// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Todo> _$todoSerializer = _$TodoSerializer();

class _$TodoSerializer implements StructuredSerializer<Todo> {
  @override
  final Iterable<Type> types = const [Todo, _$Todo];
  @override
  final String wireName = 'Todo';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Todo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      ),
      'description',
      serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      ),
      'userId',
      serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(int),
      ),
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(TodoStatus),
      ),
    ];

    return result;
  }

  @override
  Todo deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TodoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'userId':
          result.userId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'createdAt':
          result.createdAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(TodoStatus),
                  )!
                  as TodoStatus;
          break;
      }
    }

    return result.build();
  }
}

class _$Todo extends Todo {
  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String userId;
  @override
  final int createdAt;
  @override
  final TodoStatus status;

  factory _$Todo([void Function(TodoBuilder)? updates]) =>
      (TodoBuilder()..update(updates))._build();

  _$Todo._({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.createdAt,
    required this.status,
  }) : super._();
  @override
  Todo rebuild(void Function(TodoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoBuilder toBuilder() => TodoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Todo &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        userId == other.userId &&
        createdAt == other.createdAt &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Todo')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('userId', userId)
          ..add('createdAt', createdAt)
          ..add('status', status))
        .toString();
  }
}

class TodoBuilder implements Builder<Todo, TodoBuilder> {
  _$Todo? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  TodoStatus? _status;
  TodoStatus? get status => _$this._status;
  set status(TodoStatus? status) => _$this._status = status;

  TodoBuilder();

  TodoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _userId = $v.userId;
      _createdAt = $v.createdAt;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Todo other) {
    _$v = other as _$Todo;
  }

  @override
  void update(void Function(TodoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Todo build() => _build();

  _$Todo _build() {
    final _$result =
        _$v ??
        _$Todo._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Todo', 'id'),
          title: BuiltValueNullFieldError.checkNotNull(title, r'Todo', 'title'),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'Todo',
            'description',
          ),
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'Todo',
            'userId',
          ),
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'Todo',
            'createdAt',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'Todo',
            'status',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
