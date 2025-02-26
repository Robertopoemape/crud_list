import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/components.dart';
import '../../../core/core.dart';
import '../notifiers/task_notifier.dart';

@RoutePage()
class HomeRiverpodPage extends ConsumerWidget {
  const HomeRiverpodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: const Text(
            'Tareas - Riverpod',
            style: TextStyle(
              fontSize: ds20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    child: Text('No hay tareas'),
                  )
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
                                    .deleteTask(task.id);
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
            padding: const EdgeInsets.all(ds16),
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
              child: const Text('Agregar Tarea'),
            ),
          ),
        ],
      ),
    );
  }
}
