import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/todo.dart';
import '../../../models/todo_status.dart';
import 'todo_tile.dart';

class CommonBoardSection
    extends ConsumerWidget {
  final String title;

  final Color color;

  final IconData icon;

  final List<Todo> tasks;

  final TodoStatus?
  targetStatus;

  final bool enableDrag;

  const CommonBoardSection({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    required this.tasks,
    required this.targetStatus,
    required this.enableDrag,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return DragTarget<Todo>(
      onAcceptWithDetails: (
        details,
      ) async {
        // ALL TODOS should not accept drops
        if (targetStatus ==
            null) {
          return;
        }

        // UPDATE TASK STATUS
        final updatedTodo =
            details.data.rebuild(
              (builder) =>
                  builder.status =
                      targetStatus,
            );

        await ref.todoActions
            .updateTodo(
              todo: updatedTodo,
            );
      },

      builder: (
        context,
        candidateData,
        rejectedData,
      ) {
        return Container(
          decoration: BoxDecoration(
            color: color.withValues(
              alpha: 0.10,
            ),

            borderRadius:
                BorderRadius.circular(
                  24,
                ),
          ),

          child: Column(
            children: [
              // HEADER
              Container(
                padding:
                    const EdgeInsets.symmetric(
                      horizontal:
                          18,
                      vertical: 16,
                    ),

                decoration: BoxDecoration(
                  color: color,

                  borderRadius:
                      const BorderRadius.only(
                        topLeft:
                            Radius.circular(
                              24,
                            ),

                        topRight:
                            Radius.circular(
                              24,
                            ),
                      ),
                ),

                child: Row(
                  children: [
                    Icon(
                      icon,

                      color:
                          Colors.white,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child: Text(
                        title,

                        style:
                            const TextStyle(
                              color:
                                  Colors
                                      .white,

                              fontSize:
                                  16,

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                      ),
                    ),

                    CircleAvatar(
                      radius: 14,

                      backgroundColor:
                          Colors.white,

                      child: Text(
                        tasks.length
                            .toString(),

                        style:
                            TextStyle(
                              color:
                                  color,

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              // TASKS
              Expanded(
                child:
                    tasks.isEmpty
                        ? const Center(
                          child: Text(
                            'Drop Task Here',
                          ),
                        )
                        : ListView.builder(
                          padding:
                              const EdgeInsets.all(
                                14,
                              ),

                          itemCount:
                              tasks.length,

                          itemBuilder: (
                            context,
                            index,
                          ) {
                            final todo =
                                tasks[index];

                            // ONLY ALL TODOS CAN DRAG
                            if (enableDrag) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(
                                      bottom:
                                          14,
                                    ),

                                child: Draggable<
                                  Todo
                                >(
                                  data:
                                      todo,

                                  feedback:
                                      Material(
                                        color:
                                            Colors
                                                .transparent,

                                        child: SizedBox(
                                          width:
                                              280,

                                          child:
                                              TodoTile(
                                                todo:
                                                    todo,

                                                onDelete:
                                                    () {},

                                                onStatusChanged:
                                                    (
                                                      value,
                                                    ) {},
                                              ),
                                        ),
                                      ),

                                  childWhenDragging:
                                      Opacity(
                                        opacity:
                                            0.3,

                                        child:
                                            TodoTile(
                                              todo:
                                                  todo,

                                              onDelete:
                                                  () {},

                                              onStatusChanged:
                                                  (
                                                    value,
                                                  ) {},
                                            ),
                                      ),

                                  child:
                                      TodoTile(
                                        todo:
                                            todo,

                                        onDelete:
                                            () async {
                                              await ref
                                                  .todoActions
                                                  .deleteTodo(
                                                    id:
                                                        todo.id,
                                                  );
                                            },

                                        onStatusChanged:
                                            (
                                              value,
                                            ) async {
                                              final updatedTodo =
                                                  todo.rebuild(
                                                    (
                                                      builder,
                                                    ) =>
                                                        builder.status =
                                                            value
                                                                ? TodoStatus.completed
                                                                : TodoStatus.pending,
                                                  );

                                              await ref
                                                  .todoActions
                                                  .updateTodo(
                                                    todo:
                                                        updatedTodo,
                                                  );
                                            },
                                      ),
                                ),
                              );
                            }

                            
                            return Padding(
                              padding:
                                  const EdgeInsets.only(
                                    bottom: 14,
                                  ),

                              child: TodoTile(
                                todo: todo,

                                onDelete:
                                    () async {
                                  await ref
                                      .todoActions
                                      .deleteTodo(
                                        id:
                                            todo.id,
                                      );
                                },

                                onStatusChanged:
                                    (
                                      value,
                                    ) async {
                                  final updatedTodo =
                                      todo.rebuild(
                                        (
                                          builder,
                                        ) =>
                                            builder.status =
                                                value
                                                    ? TodoStatus.completed
                                                    : TodoStatus.pending,
                                      );

                                  await ref
                                      .todoActions
                                      .updateTodo(
                                        todo:
                                            updatedTodo,
                                      );
                                },
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        );
      },
    );
  }
}