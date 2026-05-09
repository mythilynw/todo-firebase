

import 'package:flutter/material.dart';

import '../../models/todo.dart';
import '../../models/todo_status.dart';
import '../widgets/todo_tile.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() =>
      _TodoListScreenState();
}

class _TodoListScreenState
    extends State<TodoListScreen> {
  List<Todo> todos = [
    // PENDING
    Todo(
      (b) => b
        ..id = '1'
        ..title =
            'Enhance Reminder Popup UI'
        ..description =
            'Improve reminder popup design'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status = TodoStatus.pending,
    ),

    Todo(
      (b) => b
        ..id = '2'
        ..title =
            'Create Login Screen'
        ..description =
            'Build responsive login UI'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status = TodoStatus.pending,
    ),

    Todo(
      (b) => b
        ..id = '3'
        ..title =
            'Setup Notifications'
        ..description =
            'Add push notifications'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status = TodoStatus.pending,
    ),

    Todo(
      (b) => b
        ..id = '4'
        ..title =
            'Deploy Application'
        ..description =
            'Publish app to Play Store'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status = TodoStatus.pending,
    ),

    // IN PROGRESS
    Todo(
      (b) => b
        ..id = '5'
        ..title =
            'Push Project to GitHub'
        ..description =
            'Upload latest source code'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status =
            TodoStatus.inProgress,
    ),

    Todo(
      (b) => b
        ..id = '6'
        ..title =
            'Design Dashboard'
        ..description =
            'Create dashboard widgets'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status =
            TodoStatus.inProgress,
    ),

    Todo(
      (b) => b
        ..id = '7'
        ..title =
            'Dark Mode Support'
        ..description =
            'Implement dark theme'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status =
            TodoStatus.inProgress,
    ),

    Todo(
      (b) => b
        ..id = '8'
        ..title =
            'API Integration'
        ..description =
            'Connect REST APIs'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status =
            TodoStatus.inProgress,
    ),

    // COMPLETED
    Todo(
      (b) => b
        ..id = '9'
        ..title =
            'Connect Firebase'
        ..description =
            'Setup firebase auth'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status =
            TodoStatus.completed,
    ),

    Todo(
      (b) => b
        ..id = '10'
        ..title =
            'Fix Navigation Bugs'
        ..description =
            'Resolve routing issues'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status =
            TodoStatus.completed,
    ),

    Todo(
      (b) => b
        ..id = '11'
        ..title =
            'Create Splash Screen'
        ..description =
            'Design startup screen'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status =
            TodoStatus.completed,
    ),

    Todo(
      (b) => b
        ..id = '12'
        ..title =
            'Setup Routing'
        ..description =
            'Configure Go Router'
        ..userId = '101'
        ..createdAt = DateTime.now()
            .millisecondsSinceEpoch
        ..status =
            TodoStatus.completed,
    ),
  ];

  bool allExpanded = true;

  bool doneExpanded = false;

  bool progressExpanded = false;

  bool pendingExpanded = false;

  // DELETE TASK
  void deleteTodo(String id) {
    setState(() {
      todos.removeWhere(
        (todo) => todo.id == id,
      );
    });
  }

  // UPDATE STATUS
  void updateStatus(
    String id,
    bool value,
  ) {
    setState(() {
      final index = todos.indexWhere(
        (todo) => todo.id == id,
      );

      todos[index] = todos[index]
          .rebuild(
            (b) => b.status = value
                ? TodoStatus.completed
                : TodoStatus.pending,
          );
    });
  }

  // SECTION 
  Widget buildSection({
    required String title,
    required Color color,
    required IconData icon,
    required List<Todo> tasks,
    required bool isExpanded,
    required Function(bool) onTap,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(
            bottom: 18,
          ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
              18,
            ),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.06),

            blurRadius: 10,

            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: Column(
        children: [
          InkWell(
            borderRadius:
                BorderRadius.circular(
                  18,
                ),

            onTap: () {
              onTap(!isExpanded);
            },

            child: Padding(
              padding:
                  const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),

              child: Row(
                children: [
                  // ARROW
                  Text(
                    isExpanded
                        ? "▲"
                        : "▶",

                    style:
                        const TextStyle(
                          fontSize: 18,

                          fontWeight:
                              FontWeight.bold,

                          color:
                              Colors.grey,
                        ),
                  ),

                  const SizedBox(width: 16),

                  // STATUS 
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),

                    decoration:
                        BoxDecoration(
                          color: color,

                          borderRadius:
                              BorderRadius.circular(
                                10,
                              ),
                        ),

                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min,

                      children: [
                        Icon(
                          icon,

                          color:
                              Colors.white,

                          size: 16,
                        ),

                        const SizedBox(
                          width: 6,
                        ),

                        Text(
                          title,

                          style:
                              const TextStyle(
                                color:
                                    Colors
                                        .white,

                                fontWeight:
                                    FontWeight
                                        .bold,

                                fontSize: 12,
                              ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // TASK COUNT
                  Text(
                    tasks.length.toString(),

                    style:
                        const TextStyle(
                          fontSize: 20,

                          color:
                              Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ),

          // TASKS
          if (isExpanded)
            Padding(
              padding:
                  const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 12,
                  ),

              child: Column(
                children:
                    tasks.map((todo) {
                      return TodoTile(
                        todo: todo,

                        onDelete: () {
                          deleteTodo(
                            todo.id,
                          );
                        },

                        onStatusChanged: (
                          value,
                        ) {
                          updateStatus(
                            todo.id,
                            value,
                          );
                        },
                      );
                    }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks =
        todos.where((todo) {
          return todo.status ==
              TodoStatus.completed;
        }).toList();

    final progressTasks =
        todos.where((todo) {
          return todo.status ==
              TodoStatus.inProgress;
        }).toList();

    final pendingTasks =
        todos.where((todo) {
          return todo.status ==
              TodoStatus.pending;
        }).toList();

    return Scaffold(
      backgroundColor:
          const Color(
            0xFFF4F7FC,
          ),

      appBar: AppBar(
        backgroundColor:
            const Color(
              0xFFF4F7FC,
            ),

        elevation: 0,

        title: const Text(
          'Task Dashboard',

          style: TextStyle(
            color: Colors.black,

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(
          20,
        ),

        child: ListView(
          children: [
            // ALL TODOS
            buildSection(
              title: "ALL TODO",

              color: Colors.purple,

              icon: Icons.list_alt,

              tasks: todos,

              isExpanded:
                  allExpanded,

              onTap: (value) {
                setState(() {
                  allExpanded = value;
                });
              },
            ),

            // DONE
            buildSection(
              title: "DONE",

              color: Colors.green,

              icon: Icons.check_circle,

              tasks: completedTasks,

              isExpanded:
                  doneExpanded,

              onTap: (value) {
                setState(() {
                  doneExpanded = value;
                });
              },
            ),

            // IN PROGRESS
            buildSection(
              title: "IN PROGRESS",

              color: Colors.orange,

              icon: Icons.timelapse,

              tasks: progressTasks,

              isExpanded:
                  progressExpanded,

              onTap: (value) {
                setState(() {
                  progressExpanded =
                      value;
                });
              },
            ),

            // PENDING
            buildSection(
              title: "TODO",

              color: Colors.blue,

              icon: Icons
                  .radio_button_unchecked,

              tasks: pendingTasks,

              isExpanded:
                  pendingExpanded,

              onTap: (value) {
                setState(() {
                  pendingExpanded =
                      value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}