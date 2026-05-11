import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../colors/app_colors.dart';
import '../../extensions/extensions.dart';
import '../../models/todo.dart';
import '../../models/todo_status.dart';
import '../widgets/common_board_section.dart';

class TodoGridScreen
    extends ConsumerStatefulWidget {
  const TodoGridScreen({
    super.key,
  });

  @override
  ConsumerState<TodoGridScreen>
  createState() =>
      _TodoGridScreenState();
}

class _TodoGridScreenState
    extends ConsumerState<TodoGridScreen> {
  final _titleController =
      TextEditingController();

  final _descriptionController =
      TextEditingController();

  TodoStatus _selectedStatus =
      TodoStatus.pending;

  @override
  void dispose() {
    _titleController.dispose();

    _descriptionController.dispose();

    super.dispose();
  }

  // FILTER TODOS

  List<Todo> _filterTodos(
    List<Todo> todos,
    TodoStatus status,
  ) {
    return todos.where((todo) {
      return todo.status ==
          status;
    }).toList();
  }

  // ADD TODO

  Future<void> _addTodo() async {
    final title =
        _titleController.text.trim();

    final description =
        _descriptionController.text
            .trim();

    if (title.isEmpty) {
      return;
    }

    final userId =
        ref
            .todoActions
            .currentUserId;

    if (userId == null) {
      return;
    }

    final todo = Todo(
      (builder) => builder
        ..id = const Uuid().v4()
        ..title = title
        ..description =
            description
        ..userId = userId
        ..createdAt =
            DateTime.now()
                .millisecondsSinceEpoch
        ..status =
            _selectedStatus,
    );

    await ref.todoActions.addTodo(
      todo: todo,
    );

    _titleController.clear();

    _descriptionController.clear();

    _selectedStatus =
        TodoStatus.pending;

    if (mounted) {
      context.pop();
    }
  }

  // SHOW ADD TASK DIALOG

  void _showAddTaskDialog() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Task',
          ),

          content: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [
              TextField(
                controller:
                    _titleController,

                decoration:
                    const InputDecoration(
                      hintText:
                          'Task Title',
                    ),
              ),

              const SizedBox(
                height: 16,
              ),

              TextField(
                controller:
                    _descriptionController,

                decoration:
                    const InputDecoration(
                      hintText:
                          'Task Description',
                    ),
              ),

              const SizedBox(
                height: 16,
              ),

              DropdownButtonFormField<
                TodoStatus
              >(
               initialValue: _selectedStatus,

                items:
                    TodoStatus
                        .values
                        .map((status) {
                          return DropdownMenuItem(
                            value:
                                status,

                            child: Text(
                              status
                                  .name,
                            ),
                          );
                        })
                        .toList(),

                onChanged: (
                  value,
                ) {
                  if (value ==
                      null) {
                    return;
                  }

                  setState(() {
                    _selectedStatus =
                        value;
                  });
                },
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed:
                  context.pop,

              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed:
                  _addTodo,

              child: const Text(
                'Add Task',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final todos = ref.todos;

    final completedTodos =
        _filterTodos(
          todos,
          TodoStatus.completed,
        );

    final pendingTodos =
        _filterTodos(
          todos,
          TodoStatus.pending,
        );

    final progressTodos =
        _filterTodos(
          todos,
          TodoStatus.inProgress,
        );

    return Scaffold(
      backgroundColor:
          AppColors.background,

      appBar: AppBar(
        elevation: 0,

        backgroundColor:
            AppColors.background,

        title: const Text(
          'Task Grid Board',
        ),

        actions: [
          Padding(
            padding:
                const EdgeInsets.only(
                  right: 20,
                ),

            child: ElevatedButton.icon(
              onPressed:
                  _showAddTaskDialog,

              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.all,
              ),

              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),

              label: const Text(
                'Add Task',

                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(
              20,
            ),

        child: LayoutBuilder(
          builder: (
            context,
            constraints,
          ) {
            return Column(
              children: [
                Expanded(
                  child: GridView.count(
                    physics:
                        const NeverScrollableScrollPhysics(),

                    crossAxisCount:
                        constraints.maxWidth <
                                1100
                            ? 2
                            : 4,

                    crossAxisSpacing:
                        18,

                    mainAxisSpacing:
                        18,

                    childAspectRatio:
                        0.58,

                    children: [
                      // ALL TODOS

                      CommonBoardSection(
                        title:
                            'ALL TODOS',

                        color:
                            AppColors.all,

                        icon:
                            Icons.list_alt,

                        tasks: todos,

                        targetStatus:
                            null,

                        enableDrag:
                            true,
                      ),

                      // DONE

                      CommonBoardSection(
                        title:
                            'DONE',

                        color:
                            AppColors.completed,

                        icon:
                            Icons.check_circle,

                        tasks:
                            completedTodos,

                        targetStatus:
                            TodoStatus
                                .completed,

                        enableDrag:
                            true,
                            
              
                      ),

                      // PENDING

                      CommonBoardSection(
                        title:
                            'PENDING',

                        color:
                            AppColors.pending,

                        icon: Icons
                            .radio_button_unchecked,

                        tasks:
                            pendingTodos,

                        targetStatus:
                            TodoStatus
                                .pending,

                        enableDrag:
                            true,
                      ),

                      // IN PROGRESS

                      CommonBoardSection(
                        title:
                            'IN PROGRESS',

                        color:
                            AppColors.progress,

                        icon:
                            Icons.timelapse,

                        tasks:
                            progressTodos,

                        targetStatus:
                            TodoStatus
                                .inProgress,

                        enableDrag:
                            true,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}