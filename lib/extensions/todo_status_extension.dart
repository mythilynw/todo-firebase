import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../models/todo_status.dart';

extension TodoStatusExtension
    on TodoStatus {

  Color get color {

    switch (this) {

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

  IconData get icon {

    switch (this) {

      case TodoStatus.completed:
        return Icons.check_circle;

      case TodoStatus.inProgress:
        return Icons.timelapse;

      case TodoStatus.pending:
        return Icons.radio_button_unchecked;

      default:
        return Icons.circle;
    }
  }
}