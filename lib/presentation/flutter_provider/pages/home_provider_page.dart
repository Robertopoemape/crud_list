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
          backgroundColor: Colors.blueAccent,
          title: const Text(
            "Tareas - Provider",
          )),
      body: CardList(
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
                    context.read<TaskProvider>().removeTask(task.id);
                    autoRouterPop(context);
                  });
            },
            onPressedSaveTask: () => showEditTaskDialog(
              context: context,
              task: task,
              onPressedSaveTask: (updatedTitle, updatedDescription) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<TaskProvider>().addTask('Nueva Tarea', 'asdasda'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
