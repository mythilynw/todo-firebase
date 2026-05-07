import 'package:flutter/material.dart';
import '../../models/todo.dart';
import '../../models/todo_status.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final Function(TodoStatus) onStatusChange;
  final VoidCallback onDelete;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onStatusChange,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),

      child: ListTile(
        title: Text(
          todo.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Text(
          todo.description.isEmpty
              ? "No description"
              : todo.description,
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // STATUS DROPDOWN
            DropdownButton<TodoStatus>(
              value: todo.status,
              underline: const SizedBox(),
              items: TodoStatus.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  onStatusChange(value);
                }
              },
            ),

            // DELETE BUTTON
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}