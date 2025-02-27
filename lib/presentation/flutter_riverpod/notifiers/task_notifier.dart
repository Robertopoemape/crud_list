import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../data/models/task_model.dart';
import '../../../data/sources/task_storage.dart';
import '../../../domain/usecases/add_task_usecase.dart';
import '../../../domain/usecases/get_task_usecase.dart';

class TaskNotifier extends StateNotifier<List<TaskModel>> {
  final TaskStorage _storage;

  final GetTask _getTasksUseCase;
  final AddTaskUseCase _addTaskUseCase;

  TaskNotifier(this._storage, this._getTasksUseCase, this._addTaskUseCase)
      : super([]) {
    _init();
  }

  Future<void> _init() async {
    try {
      await _refreshState();
      _refreshState();
    } catch (e) {
      print('Error al inicializar TaskNotifier: $e');
    }
  }

  Future<void> _refreshState() async {
    final domainTasks = await _getTasksUseCase();
    state = domainTasks.map((task) => TaskModel.fromDomain(task)).toList();
  }

  Future<void> addTask(String title, String description) async {
    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      isCompleted: false,
    ).toDomain();

    await _addTaskUseCase(newTask);
    await _refreshState();
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
  (ref) => TaskNotifier(
    GetIt.I<TaskStorage>(instanceName: "riverpod"),
    GetIt.I<GetTask>(instanceName: "riverpodGetTask"),
    GetIt.I<AddTaskUseCase>(instanceName: "riverpodAddTask"),
  ),
);
