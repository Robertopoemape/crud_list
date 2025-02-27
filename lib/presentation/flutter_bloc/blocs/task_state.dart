import '../../../data/models/task_model.dart';

abstract class TaskState {
  List<TaskModel> get tasks;
}

class TaskInitial extends TaskState {
  @override
  final List<TaskModel> tasks;

  TaskInitial([this.tasks = const []]);
}

class TaskLoaded extends TaskState {
  @override
  final List<TaskModel> tasks;
  TaskLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);

  @override
  List<TaskModel> get tasks => [];
}
