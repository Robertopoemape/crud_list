import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/show_dialog_message.dart';
import '../../../models/task_model.dart';
import '../blocs/task_bloc.dart';
import '../blocs/task_event.dart';

class TaskItemBloc extends StatelessWidget {
  const TaskItemBloc({
    super.key,
    required this.task,
  });
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          context.read<TaskBloc>().add(ToggleTask(task.id));
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditTaskDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialogMessage(
                context: context,
                task: task,
                onPressed: () {
                  context.read<TaskBloc>().add(RemoveTask(task.id));
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _showEditTaskDialog(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: task.title);
    final TextEditingController descriptionController =
        TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Tarea"),
          content: Column(
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
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  context.read<TaskBloc>().add(UpdateTask(
                        task.id,
                        titleController.text,
                        descriptionController.text,
                      ));
                  Navigator.pop(context);
                }
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }
}
