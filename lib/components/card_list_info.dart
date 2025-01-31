import 'package:flutter/material.dart';

import '../models/task_model.dart';

class CardListInfo extends StatelessWidget {
  const CardListInfo({
    required this.task,
    required this.onChangedToggleTask,
    required this.onPressedRemoveTask,
    required this.onPressedSaveTask,
    super.key,
  });

  final TaskModel task;
  final Function(bool?) onChangedToggleTask;
  final VoidCallback? onPressedRemoveTask;
  final VoidCallback? onPressedSaveTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.blue, width: 2),
        ),
        tileColor: task.isCompleted
            ? Colors.lightGreenAccent
            : Colors.limeAccent.shade100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                height: 1.1,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            Text(
              task.description,
              style: TextStyle(
                fontSize: 14,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ],
        ),
        leading:
            Checkbox(value: task.isCompleted, onChanged: onChangedToggleTask),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onPressedSaveTask,

              /* () => showEditTaskDialog(
                context: context,
                task: task,
                onPressedSaveTask: () {},
              ),*/
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onPressedRemoveTask,
            ),
          ],
        ),
      ),
    );
  }
}
