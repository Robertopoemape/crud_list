import 'package:hive/hive.dart';

import '../../models/task_model.dart';

class TaskStorage {
  final String boxName;
  late Box<TaskModel> _box;

  TaskStorage(this.boxName);

  Future<void> init() async {
    _box = await Hive.openBox<TaskModel>(boxName);
  }

  List<TaskModel> getTasks() => _box.values.toList();

  void addTask(TaskModel task) => _box.add(task);

  void updateTask(int index, TaskModel task) {
    if (index >= 0 && index < _box.length) {
      _box.putAt(index, task);
    }
  }

  void deleteTask(int index) {
    if (index >= 0 && index < _box.length) {
      _box.deleteAt(index);
    }
  }

  void updateTasks(List<TaskModel> tasks) {
    _box.clear();
    _box.addAll(tasks);
  }
}
