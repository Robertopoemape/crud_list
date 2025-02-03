import 'package:bloc/bloc.dart';

import '../../../data/local/task_storage.dart';
import '../../../models/task_model.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskStorage _storage;

  TaskBloc(this._storage) : super(TaskInitial(_storage.getTasks())) {
    on<AddTask>(_onAddTask);
    on<ToggleTask>(_onToggleTask);
    on<RemoveTask>(_onRemoveTask);
    on<UpdateTask>(_onUpdateTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: event.task.title,
      description: event.task.description,
    );
    _storage.addTask(newTask);
    emit(TaskLoaded(_storage.getTasks()));
  }

  void _onToggleTask(ToggleTask event, Emitter<TaskState> emit) {
    final updatedTasks = _storage.getTasks().map((task) {
      if (task.id == event.id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
    _storage.updateTasks(updatedTasks);
    emit(TaskLoaded(updatedTasks));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    final tasks = _storage.getTasks();
    final index = tasks.indexWhere((task) => task.id == event.id);
    if (index != -1) {
      _storage.deleteTask(index);
      emit(TaskLoaded(_storage.getTasks()));
    }
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final tasks = _storage.getTasks();
    final index = tasks.indexWhere((task) => task.id == event.id);
    if (index != -1) {
      final updatedTask = tasks[index].copyWith(
        title: event.title,
        description: event.description,
      );
      _storage.updateTask(index, updatedTask);
      emit(TaskLoaded(_storage.getTasks()));
    }
  }
}
