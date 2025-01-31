import '../../../models/task_model.dart';

abstract class TaskEvent {}

class AddTask extends TaskEvent {
  final TaskModel task;
  AddTask(this.task);
}

class ToggleTask extends TaskEvent {
  final int id;
  ToggleTask(this.id);
}

class RemoveTask extends TaskEvent {
  final int id;
  RemoveTask(this.id);
}

class UpdateTask extends TaskEvent {
  final int id;
  final String title;
  final String description;

  UpdateTask(this.id, this.title, this.description);
}
