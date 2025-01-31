import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/card_list.dart';
import '../../../components/card_list_info.dart';
import '../../../components/show_dialog_message.dart';
import '../../../components/show_edit_task_dialog.dart';
import '../blocs/task_bloc.dart';
import '../blocs/task_event.dart';
import '../blocs/task_state.dart';
import '../../../models/task_model.dart';

@RoutePage()
class HomeBlocPage extends StatelessWidget {
  const HomeBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tareas - Bloc")),
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
                    Navigator.pop(context);
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
