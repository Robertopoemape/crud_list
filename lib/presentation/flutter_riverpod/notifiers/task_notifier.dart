import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/task_model.dart';

class TaskNotifier extends StateNotifier<List<TaskModel>> {
  TaskNotifier() : super([]);

  void addTask(String title, String description) {
    final newTask = TaskModel(
      id: state.length + 1,
      title: title,
      description: description,
    );
    state = [...state, newTask];
  }

  void updateTask(int id, String newTitle, String newDescription) {
    state = state.map((task) {
      if (task.id == id) {
        return TaskModel(
          id: task.id,
          title: newTitle,
          description: newDescription,
        );
      }
      return task;
    }).toList();
  }

  void toggleTask(int id) {
    state = state.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }

      return task;
    }).toList();
  }

  void deletedTask(int id) {
    state = state.where((task) => task.id != id).toList();
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<TaskModel>>(
  (ref) => TaskNotifier(),
);
