import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../colors/app_colors.dart';
import '../../extensions/extensions.dart';
import '../../models/todo.dart';
import '../../models/todo_status.dart';
import '../widgets/common_section.dart';

class TodoListScreen
    extends ConsumerStatefulWidget {

  const TodoListScreen({
    super.key,
  });

  @override
  ConsumerState<TodoListScreen>
      createState() =>
          _TodoListScreenState();
}

class _TodoListScreenState
    extends ConsumerState<TodoListScreen> {

  final _titleController =
      TextEditingController();

  final _descriptionController =
      TextEditingController();

  TodoStatus _selectedStatus =
      TodoStatus.pending;

  bool _allExpanded = true;

  bool _completedExpanded =
      false;

  bool _progressExpanded =
      false;

  bool _pendingExpanded =
      false;

  @override
  void dispose() {

    _titleController.dispose();

    _descriptionController.dispose();

    super.dispose();
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

        ..id =
            const Uuid().v4()

        ..title =
            title

        ..description =
            description

        ..userId =
            userId

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

    setState(() {

      _selectedStatus =
          TodoStatus.pending;
    });

    if (mounted) {

      context.pop();
    }
  }

  // DELETE TODO

  Future<void> _deleteTodo(
    String id,
  ) async {

    await ref.todoActions
        .deleteTodo(
      id: id,
    );
  }

  // UPDATE STATUS

  Future<void> _updateStatus(
    Todo todo,
    bool value,
  ) async {

    final updatedTodo =
        todo.rebuild(
      (builder) =>
          builder.status =
              value
                  ? TodoStatus.completed
                  : TodoStatus.pending,
    );

    await ref.todoActions
        .updateTodo(
      todo: updatedTodo,
    );
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

  // SHOW ADD TODO DIALOG

  void _showAddTodoDialog() {

    showDialog(
      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            'Add Todo',
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
                      'Enter title',
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
                      'Enter description',
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              DropdownButtonFormField<
                  TodoStatus>(

                initialValue:
                    _selectedStatus,

                decoration:
                    const InputDecoration(
                  labelText:
                      'Task Status',
                ),

                items:
                    TodoStatus.values
                        .map((status) {

                  return DropdownMenuItem(

                    value: status,

                    child: Text(
                      status.name,
                    ),
                  );
                }).toList(),

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
                'Add',
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

    final todos =
        ref.todos;

    final completedTodos =
        _filterTodos(
      todos,
      TodoStatus.completed,
    );

    final progressTodos =
        _filterTodos(
      todos,
      TodoStatus.inProgress,
    );

    final pendingTodos =
        _filterTodos(
      todos,
      TodoStatus.pending,
    );

    final sections = [

      TodoSection(

        title:
            'ALL TODO',

        color:
            AppColors.all,

        icon:
            Icons.list_alt,

        tasks:
            todos,

        expanded:
            _allExpanded,

        onTap: () {

          setState(() {

            _allExpanded =
                !_allExpanded;
          });
        },
      ),

      TodoSection(

        title:
            'DONE',

        color:
            AppColors.completed,

        icon:
            Icons.check_circle,

        tasks:
            completedTodos,

        expanded:
            _completedExpanded,

        onTap: () {

          setState(() {

            _completedExpanded =
                !_completedExpanded;
          });
        },
      ),

      TodoSection(

        title:
            'IN PROGRESS',

        color:
            AppColors.progress,

        icon:
            Icons.timelapse,

        tasks:
            progressTodos,

        expanded:
            _progressExpanded,

        onTap: () {

          setState(() {

            _progressExpanded =
                !_progressExpanded;
          });
        },
      ),

      TodoSection(

        title:
            'PENDING',

        color:
            AppColors.pending,

        icon:
            Icons.radio_button_unchecked,

        tasks:
            pendingTodos,

        expanded:
            _pendingExpanded,

        onTap: () {

          setState(() {

            _pendingExpanded =
                !_pendingExpanded;
          });
        },
      ),
    ];

    return Scaffold(

      backgroundColor:
          AppColors.background,

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            AppColors.background,

        title: const Text(
          'Task Dashboard',
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed:
            _showAddTodoDialog,

        backgroundColor:
            AppColors.all,

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body:
          SingleChildScrollView(

        padding:
            const EdgeInsets.all(
          20,
        ),

        child: Column(

          children:
              sections.map((section) {

            return CommonSection(

              section: section,

              onDelete:
                  _deleteTodo,

              onStatusChanged:
                  _updateStatus,
            );

          }).toList(),
        ),
      ),
    );
  }
}