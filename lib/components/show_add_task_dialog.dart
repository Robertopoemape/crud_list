import 'package:flutter/material.dart';

import '../core/router/router.dart';

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
            onPressed: () => autoRouterPop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                onPressedAddTask(
                    titleController.text, descriptionController.text);
              }
              autoRouterPop(context);
            },
            child: const Text("Agregar"),
          ),
        ],
      );
    },
  );
}
