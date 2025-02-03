import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local/task_storage.dart';
import '../../../models/task_model.dart';

class TaskNotifier extends StateNotifier<List<TaskModel>> {
  final TaskStorage _storage;

  TaskNotifier(this._storage) : super([]) {
    _init();
  }

  Future<void> _init() async {
    try {
      await _storage.init();
      _refreshState();
    } catch (e) {
      print('Error al inicializar TaskNotifier: $e');
    }
  }

  void _refreshState() {
    state = _storage.getTasks();
  }

  void addTask(String title, String description) {
    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      isCompleted: false,
    );
    _storage.addTask(newTask);
    _refreshState();
  }

  void updateTask(int id, String newTitle, String newDescription) {
    final index = state.indexWhere((task) => task.id == id);
    if (index != -1) {
      final updatedTask = state[index].copyWith(
        title: newTitle,
        description: newDescription,
      );
      _storage.updateTask(index, updatedTask);
      _refreshState();
    }
  }

  void toggleTask(int id) {
    final index = state.indexWhere((task) => task.id == id);
    if (index != -1) {
      final updatedTask = state[index].copyWith(
        isCompleted: !state[index].isCompleted,
      );
      _storage.updateTask(index, updatedTask);
      _refreshState();
    }
  }

  void deleteTask(int id) {
    final index = state.indexWhere((task) => task.id == id);
    if (index != -1) {
      _storage.deleteTask(index);
      _refreshState();
    }
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<TaskModel>>(
  (ref) => TaskNotifier(TaskStorage('tasks_riverpod')),
);
