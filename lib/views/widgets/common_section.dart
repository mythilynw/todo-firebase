import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';
import '../../models/todo.dart';
import 'todo_tile.dart';
import 'section_header.dart';

class TodoSection {

  final String title;

  final Color color;

  final IconData icon;

  final List<Todo> tasks;

  final bool expanded;

  final VoidCallback onTap;

  const TodoSection({

    required this.title,

    required this.color,

    required this.icon,

    required this.tasks,

    required this.expanded,

    required this.onTap,
  });
}

class CommonSection
    extends StatelessWidget {

  final TodoSection section;

  final Function(String) onDelete;

  final Function(
    Todo todo,
    bool value,
  ) onStatusChanged;

  const CommonSection({

    super.key,

    required this.section,

    required this.onDelete,

    required this.onStatusChanged,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      decoration: BoxDecoration(

        color: AppColors.white,

        borderRadius:
            BorderRadius.circular(
          18,
        ),

        boxShadow: [

          BoxShadow(

            color: Colors.black
                .withValues(
              alpha: 0.06,
            ),

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

          CommonSectionHeader(

            title:
                section.title,

            color:
                section.color,

            icon:
                section.icon,

            count:
                section.tasks.length,

            expanded:
                section.expanded,

            onTap:
                section.onTap,
          ),

          if (section.expanded)

            ListView.builder(

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              padding:
                  const EdgeInsets.only(
                left: 12,
                right: 12,
                bottom: 12,
              ),

              itemCount:
                  section.tasks.length,

              itemBuilder: (
                context,
                index,
              ) {

                final todo =
                    section.tasks[index];

                return TodoTile(

                  todo: todo,

                  onDelete: () {

                    onDelete(
                      todo.id,
                    );
                  },

                  onStatusChanged: (
                    value,
                  ) {

                    onStatusChanged(
                      todo,
                      value,
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}