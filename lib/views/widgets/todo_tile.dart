import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';

import '../../extensions/todo_status_extension.dart';

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

              color:
                  todo.status.color
                      .withValues(
                alpha: 0.12,
              ),

              shape:
                  BoxShape.circle,
            ),

            child: Icon(

              todo.status.icon,

              color:
                  todo.status.color,

              size: 20,
            ),
          ),

          const SizedBox(
            width: 14,
          ),

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

            onPressed:
                onDelete,

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