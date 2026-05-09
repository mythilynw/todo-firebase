
import 'package:flutter/material.dart';

import '../../models/todo.dart';
import '../../models/todo_status.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  final VoidCallback onDelete;

  final Function(bool) onStatusChanged;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onStatusChanged,
  });

  Color getStatusColor() {
    switch (todo.status) {
      case TodoStatus.completed:
        return Colors.green;

      case TodoStatus.inProgress:
        return Colors.orange;

      case TodoStatus.pending:
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon() {
    switch (todo.status) {
      case TodoStatus.completed:
        return Icons.check_circle;

      case TodoStatus.inProgress:
        return Icons.timelapse;

      case TodoStatus.pending:
        return Icons
            .radio_button_unchecked;

      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isCompleted =
        todo.status ==
        TodoStatus.completed;

    return Container(
      margin:
          const EdgeInsets.only(
            bottom: 12,
          ),

      padding:
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),

      decoration: BoxDecoration(
        color: const Color(
          0xFFF8FAFC,
        ),

        borderRadius:
            BorderRadius.circular(
              16,
            ),

        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),
      ),

      child: Row(
        children: [
          // STATUS ICON
          Container(
            width: 38,
            height: 38,

            decoration: BoxDecoration(
              color: getStatusColor()
                  .withOpacity(0.12),

              shape: BoxShape.circle,
            ),

            child: Icon(
              getStatusIcon(),

              color: getStatusColor(),

              size: 20,
            ),
          ),

          const SizedBox(width: 14),

          // TASK DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  todo.title,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      const TextStyle(
                        fontSize: 15,

                        fontWeight:
                            FontWeight.bold,

                        color: Color(
                          0xFF111827,
                        ),
                      ),
                ),

                const SizedBox(height: 4),

                Text(
                  todo.description,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      const TextStyle(
                        fontSize: 12,

                        color: Color(
                          0xFF6B7280,
                        ),
                      ),
                ),
              ],
            ),
          ),

          // CHECKBOX
          Checkbox(
            value: isCompleted,

            activeColor:
                Colors.green,

            onChanged: (value) {
              onStatusChanged(
                value!,
              );
            },
          ),

          // DELETE BUTTON
          IconButton(
            onPressed: onDelete,

            icon: const Icon(
              Icons.delete_outline,

              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}