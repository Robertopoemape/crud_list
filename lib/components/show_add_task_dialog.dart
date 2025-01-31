import 'package:flutter/material.dart';

void showAddTaskDialog({
  required BuildContext context,
  required Function(String title, String description) onPressedAddTask,
}) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Nueva Tarea"),
        content: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: "Escribe la tarea"),
            ),
            TextField(
              controller: descriptionController,
              decoration:
                  const InputDecoration(hintText: "Escribe la descripcion"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                /*  ref.read(taskProvider.notifier).addTask(
                        titleController.text,
                        descriptionController.text,
                      );*/
                onPressedAddTask(
                    titleController.text, descriptionController.text);
              }
              Navigator.pop(context);
            },
            child: const Text("Agregar"),
          ),
        ],
      );
    },
  );
}
