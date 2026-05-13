import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

import '../../../models/todo.dart';
import '../../../models/todo_status.dart';

import '../todo/todo_service.dart';

class SqfliteTodoService
    implements TodoService {

  static Database? _database;

  Future<Database> get database async {

    if (_database != null) {
      return _database!;
    }

    _database =
        await _initDatabase();

    return _database!;
  }

  // INIT DATABASE

  Future<Database>
      _initDatabase() async {

    final path = join(
      await getDatabasesPath(),
      'todo.db',
    );

    print('DATABASE PATH: $path');
   

    return await openDatabase(

      path,

      version: 1,

      onCreate: (db, version) async {

        await db.execute('''
          CREATE TABLE todos(
            id TEXT PRIMARY KEY,
            title TEXT,
            description TEXT,
            userId TEXT,
            createdAt INTEGER,
            status TEXT
          )
        ''');
      },
    );
  }

  // ADD TODO

  @override
  Future<void> addTodo({
    required Todo todo,
  }) async {

    final db =
        await database;

    await db.insert(
      'todos',
      {
        'id': todo.id,
        'title': todo.title,
        'description':
            todo.description,
        'userId':
            todo.userId,
        'createdAt':
            todo.createdAt,
        'status':
            todo.status.name,
      },
    );

    print('TODO ADDED');
  }

  // GET TODOS

  @override
  Future<List<Todo>> getTodos({
    required String userId,
  }) async {

    final db =
        await database;

    final result =
        await db.query(
      'todos',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    print(result);

    return result.map((map) {

      return Todo(
        (builder) => builder

          ..id =
              map['id']
                  as String

          ..title =
              map['title']
                  as String

          ..description =
              map['description']
                  as String

          ..userId =
              map['userId']
                  as String

          ..createdAt =
              map['createdAt']
                  as int

          ..status =
              TodoStatus.values
                  .firstWhere(
            (status) {

              return status.name ==
                  map['status'];
            },
          ),
      );

    }).toList();
  }

  // UPDATE TODO

  @override
  Future<void> updateTodo({
    required Todo todo,
  }) async {

    final db =
        await database;

    await db.update(

      'todos',

      {
        'title': todo.title,
        'description':
            todo.description,
        'status':
            todo.status.name,
      },

      where: 'id = ?',

      whereArgs: [todo.id],
    );

    print('TODO UPDATED');
  }

  // DELETE TODO

  @override
  Future<void> deleteTodo({
    required String id,
  }) async {

    final db =
        await database;

    await db.delete(

      'todos',

      where: 'id = ?',

      whereArgs: [id],
    );

    print('TODO DELETED');
  }
}