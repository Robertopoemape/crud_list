import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/task_item_provider.dart';

@RoutePage()
class HomeProviderPage extends StatelessWidget {
  const HomeProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().tasks;

    return Scaffold(
      appBar: AppBar(title: const Text("Tareas - Provider")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => TaskItemProvider(task: tasks[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<TaskProvider>().addTask('Nueva Tarea', 'asdasda'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
