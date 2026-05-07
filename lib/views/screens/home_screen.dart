import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../extensions/extensions.dart';
import '../../models/todo.dart';
import '../../models/todo_status.dart';
import '../widgets/todo_tile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        ref.todoActions.loadTodos(userId: user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.todos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),

      body: todos.isEmpty
          ? const Center(
              child: Text('No Tasks'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return GestureDetector(
                  onTap: () => _editTask(todo),
                  child: TodoTile(
                    todo: todo,
                    onStatusChange: (status) {
                      final updated =
                          todo.rebuild((b) => b..status = status);

                      ref.todoActions.updateTodo(todo: updated);
                    },
                    onDelete: () {
                      ref.todoActions.deleteTodo(id: todo.id);
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  // ADD TASK
  void _addTask() {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add Task"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;

                if (user == null) return;

                final todo = Todo((b) => b
                  ..id = DateTime.now()
                      .millisecondsSinceEpoch
                      .toString()
                  ..title = titleController.text.trim()
                  ..description = descController.text.trim()
                  ..userId = user.uid
                  ..createdAt =
                      DateTime.now().millisecondsSinceEpoch
                  ..status = TodoStatus.pending);

                ref.todoActions.addTodo(todo: todo);

                context.pop();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  // EDIT TASK
  void _editTask(Todo todo) {
    final titleController =
        TextEditingController(text: todo.title);

    final descController =
        TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Task"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                final updated = todo.rebuild((b) => b
                  ..title = titleController.text.trim()
                  ..description =
                      descController.text.trim());

                ref.todoActions.updateTodo(todo: updated);

                context.pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}