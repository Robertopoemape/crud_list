import 'package:flutter/material.dart';

import '../../../data/local/task_storage.dart';
import '../../../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final TaskStorage _storage;
  List<TaskModel> _tasks = [];

  TaskProvider() : _storage = TaskStorage("tasks_provider") {
    _init();
  }

  Future<void> _init() async {
    try {
      await _storage.init();
      _refreshTasks();
    } catch (e) {
      print('Error al inicializar TaskProvider: $e');
    }
  }

  void _refreshTasks() {
    _tasks = _storage.getTasks();
    notifyListeners();
  }

  List<TaskModel> get tasks => _tasks;

  void addTask(String title, String description) {
    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      isCompleted: false,
    );
    _storage.addTask(newTask);
    _refreshTasks();
  }

  void toggleTask(int id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final updatedTask = _tasks[index].copyWith(
        isCompleted: !_tasks[index].isCompleted,
      );
      _storage.updateTask(index, updatedTask);
      _refreshTasks();
    }
  }

  void updateTask(int id, String title, String description) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final updatedTask = _tasks[index].copyWith(
        title: title,
        description: description,
      );
      _storage.updateTask(index, updatedTask);
      _refreshTasks();
    }
  }

  void removeTask(int id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _storage.deleteTask(index);
      _refreshTasks();
    }
  }
}
