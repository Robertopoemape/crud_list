import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/components.dart';
import '../../../core/router/router.dart';
import '../providers/providers.dart';

@RoutePage()
class HomeProviderPage extends StatelessWidget {
  const HomeProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listTask = context.watch<TaskProvider>().tasks;

    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: const Text(
            "Tareas - Provider",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: listTask.isEmpty
                ? const Center(child: Text("No hay tareas"))
                : CardList(
                    listTask: listTask,
                    itemBuilder: (context, task) {
                      return CardListInfo(
                        task: task,
                        onChangedToggleTask: (value) {
                          context.read<TaskProvider>().toggleTask(task.id);
                        },
                        onPressedRemoveTask: () {
                          showDialogMessage(
                              context: context,
                              task: task,
                              onPressed: () {
                                context
                                    .read<TaskProvider>()
                                    .removeTask(task.id);
                                autoRouterPop(context);
                              });
                        },
                        onPressedSaveTask: () => showEditTaskDialog(
                          context: context,
                          task: task,
                          onPressedSaveTask:
                              (updatedTitle, updatedDescription) {
                            context.read<TaskProvider>().updateTask(
                                  task.id,
                                  updatedTitle,
                                  updatedDescription,
                                );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<TaskProvider>().addTask('Nueva Tarea', 'asdasda'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
