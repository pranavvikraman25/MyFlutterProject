import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final Function(bool?) onChanged;
  final Function() onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: onChanged,
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
