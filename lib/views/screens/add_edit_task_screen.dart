import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../extensions/extensions.dart';
import '../../models/todo.dart';
import '../../models/todo_status.dart';
import '../widgets/custom_textformfield.dart';

class AddEditTaskScreen extends ConsumerStatefulWidget {
  const AddEditTaskScreen({super.key});

  @override
  ConsumerState<AddEditTaskScreen> createState() =>
      _AddEditTaskScreenState();
}

class _AddEditTaskScreenState
    extends ConsumerState<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required field';
    }
    return null;
  }

  void handleSave() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Get logged-in user
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          throw 'User not logged in';
        }

        // Create Todo
        final todo = Todo((b) => b
          ..id = DateTime.now().millisecondsSinceEpoch.toString()
          ..title = titleController.text.trim()
          ..description = descriptionController.text.trim()
          ..userId = user.uid
          ..createdAt = DateTime.now().millisecondsSinceEpoch
          ..status = TodoStatus.pending);

        
        await ref.todoActions.addTodo(todo: todo);

        if (!mounted) return;

        
        context.pop();
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              
              CustomTextFormField(
                controller: titleController,
                label: 'Title',
                validator: validate,
              ),

              const SizedBox(height: 16),

              CustomTextFormField(
                controller: descriptionController,
                label: 'Description',
                validator: validate,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: handleSave,
                child: const Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}