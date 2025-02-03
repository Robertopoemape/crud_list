import 'package:hive/hive.dart';
import '../../models/task_model.dart';

class TaskStorage {
  static final TaskStorage _instance = TaskStorage._internal();
  late Box<TaskModel> _taskBox;

  factory TaskStorage() {
    return _instance;
  }

  TaskStorage._internal();

  Future<void> init() async {
    _taskBox = await Hive.openBox<TaskModel>('tasks');
  }

  List<TaskModel> getTasks() {
    return _taskBox.values.toList();
  }

  void addTask(TaskModel task) {
    _taskBox.add(task);
  }

  void updateTask(int index, TaskModel updatedTask) {
    _taskBox.putAt(index, updatedTask);
  }

  void deleteTask(int index) {
    _taskBox.deleteAt(index);
  }
}
