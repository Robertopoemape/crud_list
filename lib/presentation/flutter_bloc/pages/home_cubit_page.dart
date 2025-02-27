import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/components.dart';
import '../../../core/core.dart';
import '../../../domain/entities/task.dart';
import '../blocs/blocs.dart';

@RoutePage()
class HomeCubitPage extends StatelessWidget {
  const HomeCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          'Tareas - Cubit',
          style: TextStyle(
            fontSize: ds20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state.tasks.isEmpty) {
            return const Center(child: Text('No hay tareas'));
          }
          return CardList(
            listTask: state.tasks,
            itemBuilder: (context, task) => CardListInfo(
              task: task,
              onChangedToggleTask: (value) {
                context.read<TaskCubit>().toggleTask(task.id);
              },
              onPressedRemoveTask: () {
                showDialogMessage(
                  context: context,
                  task: task,
                  onPressed: () {
                    context.read<TaskCubit>().removeTask(task.id);
                    autoRouterPop(context);
                  },
                );
              },
              onPressedSaveTask: () => showEditTaskDialog(
                context: context,
                task: task,
                onPressedSaveTask: (updatedTitle, updatedDescription) {
                  if (task.title.isNotEmpty) {
                    context.read<TaskCubit>().updateTask(
                          task.id,
                          updatedTitle,
                          updatedDescription,
                        );
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.blue,
        onPressed: () => context.read<TaskCubit>().addTask(
              Task(id: ints0, title: 'Nueva Tarea', description: ''),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
