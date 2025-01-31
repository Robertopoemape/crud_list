import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/components.dart';
import '../../../core/core.dart';
import '../../../models/task_model.dart';
import '../blocs/blocs.dart';

@RoutePage()
class HomeBlocPage extends StatelessWidget {
  const HomeBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text("Tareas - Bloc")),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.tasks.isEmpty) {
            return const Center(child: Text("No hay tareas"));
          }
          return CardList(
            listTask: state.tasks,
            itemBuilder: (context, task) => CardListInfo(
              task: task,
              onChangedToggleTask: (value) {
                context.read<TaskBloc>().add(ToggleTask(task.id));
              },
              onPressedRemoveTask: () {
                showDialogMessage(
                  context: context,
                  task: task,
                  onPressed: () {
                    context.read<TaskBloc>().add(RemoveTask(task.id));
                    autoRouterPop(context);
                  },
                );
              },
              onPressedSaveTask: () => showEditTaskDialog(
                context: context,
                task: task,
                onPressedSaveTask: (updatedTitle, updatedDescription) {
                  if (task.title.isNotEmpty) {
                    context.read<TaskBloc>().add(UpdateTask(
                          task.id,
                          updatedTitle,
                          updatedDescription,
                        ));
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<TaskBloc>().add(
              AddTask(
                TaskModel(id: 0, title: "Nueva Tarea", description: ""),
              ),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
