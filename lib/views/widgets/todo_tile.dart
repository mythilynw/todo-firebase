import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';
import '../../models/todo.dart';
import '../../models/todo_status.dart';

class TodoTile
    extends StatelessWidget {
  final Todo todo;

  final VoidCallback onDelete;

  final Function(bool)
  onStatusChanged;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onStatusChanged,
  });

  Color getStatusColor() {
    switch (todo.status) {
      case TodoStatus.completed:
        return AppColors.completed;

      case TodoStatus.inProgress:
        return AppColors.progress;

      case TodoStatus.pending:
        return AppColors.pending;

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
    final isCompleted =
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
        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(
              16,
            ),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,

            decoration: BoxDecoration(
              color: getStatusColor()
                  .withValues(
                    alpha: 0.12,
                  ),

              shape: BoxShape.circle,
            ),

            child: Icon(
              getStatusIcon(),

              color: getStatusColor(),

              size: 20,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                Text(
                  todo.title,

                  style:
                      const TextStyle(
                        fontSize: 15,

                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  todo.description,

                  style:
                      const TextStyle(
                        fontSize: 12,

                        color:
                            Colors.grey,
                      ),
                ),
              ],
            ),
          ),

          Checkbox(
            value: isCompleted,

            activeColor:
                AppColors.completed,

            onChanged: (value) {
              onStatusChanged(
                value!,
              );
            },
          ),

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