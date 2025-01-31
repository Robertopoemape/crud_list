import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_bloc.dart';
import '../blocs/task_event.dart';
import '../blocs/task_state.dart';
import '../../../models/task_model.dart';
import '../widgets/task_item_block.dart';

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
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) => TaskItemBloc(
              task: state.tasks[index],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<TaskBloc>().add(
              AddTask(
                TaskModel(
                    id: 0,
                    title: "Nueva Tarea",
                    description: "Descripción de la tarea"),
              ),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
