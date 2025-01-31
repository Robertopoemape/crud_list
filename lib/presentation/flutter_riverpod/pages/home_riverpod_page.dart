import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/card_list.dart';
import '../../../components/card_list_info.dart';
import '../../../components/show_add_task_dialog.dart';
import '../../../components/show_dialog_message.dart';
import '../../../components/show_edit_task_dialog.dart';
import '../../../core/router/router.dart';
import '../notifiers/task_notifier.dart';

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
                : CardList(
                    listTask: tasks,
                    itemBuilder: (context, task) => CardListInfo(
                        task: task,
                        onChangedToggleTask: (value) {
                          ref.read(taskProvider.notifier).toggleTask(task.id);
                        },
                        onPressedRemoveTask: () {
                          showDialogMessage(
                              context: context,
                              task: task,
                              onPressed: () async {
                                ref
                                    .read(taskProvider.notifier)
                                    .deletedTask(task.id);
                                await autoRouterPopWithAwait(context);
                              });
                        },
                        onPressedSaveTask: () {
                          showEditTaskDialog(
                            context: context,
                            task: task,
                            onPressedSaveTask:
                                (updatedTitle, updatedDescription) {
                              if (task.title.isNotEmpty) {
                                ref.read(taskProvider.notifier).updateTask(
                                      task.id,
                                      updatedTitle,
                                      updatedDescription,
                                    );
                              }
                            },
                          );
                        }),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => showAddTaskDialog(
                context: context,
                onPressedAddTask: (newTitle, newDescription) {
                  ref.read(taskProvider.notifier).addTask(
                        newTitle,
                        newDescription,
                      );
                },
              ),
              child: const Text("Agregar Tarea"),
            ),
          ),
        ],
      ),
    );
  }
}
