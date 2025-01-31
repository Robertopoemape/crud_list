import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/task_notifier.dart';
import '../widgets/task_item_riverpod.dart';

@RoutePage()
class HomeRiverpodPage extends ConsumerWidget {
  const HomeRiverpodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Tareas - Riverpod")),
      body: Column(
        children: [
          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text("No hay tareas"))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskItemRiverpod(task: task);
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _showAddTaskDialog(context, ref),
              child: const Text("Agregar Tarea"),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
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
                  ref.read(taskProvider.notifier).addTask(
                        titleController.text,
                        descriptionController.text,
                      );
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
}
