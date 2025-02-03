import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local/task_storage.dart';
import '../../../models/task_model.dart';

class TaskNotifier extends StateNotifier<List<TaskModel>> {
  final TaskStorage _storage;

  TaskNotifier(this._storage) : super([]) {
    _loadTasks();
  }

  void _loadTasks() {
    state = _storage.getTasks();
  }

  void addTask(String title, String description) {
    final newTask = TaskModel(
      id: state.length + 1,
      title: title,
      description: description,
    );
    _storage.addTask(newTask);
    state = [..._storage.getTasks()];
  }

  void updateTask(int id, String newTitle, String newDescription) {
    final index = state.indexWhere((task) => task.id == id);
    if (index != -1) {
      final updatedTask = state[index].copyWith(
        title: newTitle,
        description: newDescription,
      );
      _storage.updateTask(index, updatedTask);
      state = [..._storage.getTasks()];
    }
  }

  void toggleTask(int id) {
    final index = state.indexWhere((task) => task.id == id);
    if (index != -1) {
      final updatedTask = state[index].copyWith(
        isCompleted: !state[index].isCompleted,
      );
      _storage.updateTask(index, updatedTask);
      state = [..._storage.getTasks()];
    }
  }

  void deleteTask(int id) {
    final index = state.indexWhere((task) => task.id == id);
    if (index != -1) {
      _storage.deleteTask(index);
      state = [..._storage.getTasks()];
    }
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<TaskModel>>(
  (ref) => TaskNotifier(TaskStorage()),
);
