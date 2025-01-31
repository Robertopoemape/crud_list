import 'package:flutter/material.dart';

import '../../../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void addTask(String title, String description) {
    _tasks.add(TaskModel(
        id: _tasks.length + 1, title: title, description: description));
    notifyListeners();
  }

  void toggleTask(int id) {
    _tasks = _tasks.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
    notifyListeners();
  }

  void updateTask(int id, String title, String description) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex] =
          _tasks[taskIndex].copyWith(title: title, description: description);
      notifyListeners();
    }
  }

  void removeTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
