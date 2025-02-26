import '../../../data/models/task_model.dart';

abstract class TaskState {
  List<TaskModel> get tasks => [];
}

class TaskInitial extends TaskState {
  @override
  final List<TaskModel> tasks;

  TaskInitial([this.tasks = const []]);
}

class TaskLoaded extends TaskState {
  final List<TaskModel> taskList;
  TaskLoaded(this.taskList);

  @override
  List<TaskModel> get tasks => taskList;
}
