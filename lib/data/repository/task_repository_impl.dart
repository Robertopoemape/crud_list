// lib/data/repositories/task_repository_impl.dart
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';
import '../sources/task_storage.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskStorage taskStorage;

  TaskRepositoryImpl({required this.taskStorage});

  @override
  Future<List<Task>> getTasks() async {
    final models = taskStorage.getTasks();
    return models.map((model) => model.toDomain()).toList();
  }

  @override
  Future<void> addTask(Task task) async {
    taskStorage.addTask(TaskModel.fromDomain(task));
  }

  @override
  Future<void> updateTask(int index, Task task) async {
    taskStorage.updateTask(index, TaskModel.fromDomain(task));
  }

  @override
  Future<void> deleteTask(int index) async {
    taskStorage.deleteTask(index);
  }

  @override
  Future<void> updateTasks(List<Task> tasks) async {
    final models = tasks.map((task) => TaskModel.fromDomain(task)).toList();
    taskStorage.updateTasks(models);
  }
}
