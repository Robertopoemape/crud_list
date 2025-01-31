import 'package:flutter/material.dart';
import '../models/task_model.dart';

void showEditTaskDialog({
  required BuildContext context,
  required TaskModel task,
  required Function(String title, String description) onPressedSaveTask,
}) {
  final TextEditingController titleController =
      TextEditingController(text: task.title);
  final TextEditingController descriptionController =
      TextEditingController(text: task.description);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Editar tarea'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Descripción"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                onPressedSaveTask(
                    titleController.text, descriptionController.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );
}
