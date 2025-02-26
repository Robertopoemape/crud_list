import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../data/models/task_model.dart';
import '../../../data/sources/task_storage.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/usecases/add_task_usecase.dart';
import '../../../domain/usecases/get_task_usecase.dart';

class TaskProvider with ChangeNotifier {
  TaskProvider() {
    _init();
  }

  final TaskStorage _storage = GetIt.I<TaskStorage>(instanceName: "provider");
  final GetTask _getTasksUseCase =
      GetIt.I<GetTask>(instanceName: "providerGetTask");
  final AddTask _addTaskUseCase =
      GetIt.I<AddTask>(instanceName: "providerAddTask");
  List<TaskModel> _tasks = [];

  Future<void> _init() async {
    try {
      await _storage.init();
      _refreshTasks();
    } catch (e) {
      print('Error al inicializar TaskProvider: $e');
    }
  }

  Future<void> _refreshTasks() async {
    final domainTasks = await _getTasksUseCase();
    _tasks = domainTasks.map((task) => TaskModel.fromDomain(task)).toList();
    notifyListeners();
  }

  List<TaskModel> get tasks => _tasks;

  Future<void> addNewTask(String title, String description) async {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      isCompleted: false,
    );
    await _addTaskUseCase(newTask);
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
