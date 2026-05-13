import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/todo.dart';
import '../../../models/todo_status.dart';
import 'todo_tile.dart';

class TodoBoardSection {

  final String title;

  final Color color;

  final IconData icon;

  final List<Todo> tasks;

  final TodoStatus? targetStatus;

  final bool enableDrag;

  const TodoBoardSection({

    required this.title,

    required this.color,

    required this.icon,

    required this.tasks,

    required this.targetStatus,

    required this.enableDrag,
  });
}

class CommonBoardSection
    extends ConsumerWidget {

  final TodoBoardSection section;

  const CommonBoardSection({

    super.key,

    required this.section,
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

        if (section.targetStatus ==
            null) {
          return;
        }

        final updatedTodo =
            details.data.rebuild(
          (builder) =>
              builder.status =
                  section.targetStatus,
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

            color:
                section.color.withValues(
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
                  horizontal: 18,
                  vertical: 16,
                ),

                decoration: BoxDecoration(

                  color:
                      section.color,

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

                      section.icon,

                      color:
                          Colors.white,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(

                      child: Text(

                        section.title,

                        style:
                            const TextStyle(

                          color:
                              Colors.white,

                          fontSize: 16,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    CircleAvatar(

                      radius: 14,

                      backgroundColor:
                          Colors.white,

                      child: Text(

                        section.tasks.length
                            .toString(),

                        style: TextStyle(

                          color:
                              section.color,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // TASKS

              Expanded(

                child:
                    section.tasks.isEmpty

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
                                section.tasks.length,

                            itemBuilder: (
                              context,
                              index,
                            ) {

                              final todo =
                                  section.tasks[index];

                              if (section.enableDrag) {

                                return Padding(

                                  padding:
                                      const EdgeInsets.only(
                                    bottom: 14,
                                  ),

                                  child:
                                      Draggable<Todo>(

                                    data: todo,

                                    feedback:
                                        Material(

                                      color: Colors
                                          .transparent,

                                      child: SizedBox(

                                        width: 280,

                                        child: TodoTile(

                                          todo: todo,

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

                                      opacity: 0.3,

                                      child: TodoTile(

                                        todo: todo,

                                        onDelete:
                                            () {},

                                        onStatusChanged:
                                            (
                                          value,
                                        ) {},
                                      ),
                                    ),

                                    child: TodoTile(

                                      todo: todo,

                                      onDelete:
                                          () async {

                                        await ref
                                            .todoActions
                                            .deleteTodo(
                                          id: todo.id,
                                        );
                                      },

                                      onStatusChanged:
                                          (
                                        value,
                                      ) async {

                                        final updatedTodo =
                                            todo.rebuild(
                                          (builder) =>
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
                                      id: todo.id,
                                    );
                                  },

                                  onStatusChanged:
                                      (
                                    value,
                                  ) async {

                                    final updatedTodo =
                                        todo.rebuild(
                                      (builder) =>
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