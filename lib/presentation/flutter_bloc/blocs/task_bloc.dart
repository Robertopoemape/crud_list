import 'package:bloc/bloc.dart';

import '../../../models/task_model.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddTask>((event, emit) {
      final currentTasks =
          (state is TaskLoaded) ? (state as TaskLoaded).tasks : <TaskModel>[];

      final newId = currentTasks.length + 1;

      final newTask = TaskModel(
        id: newId,
        title: event.task.title,
        description: event.task.description,
      );
      final updatedTasks = <TaskModel>[...currentTasks, newTask];

      emit(TaskLoaded(updatedTasks));
    });

    on<ToggleTask>((event, emit) {
      final updatedTasks = state.tasks.map((task) {
        if (task.id == event.id) {
          return task.copyWith(isCompleted: !task.isCompleted);
        }
        return task;
      }).toList();
      emit(TaskLoaded(updatedTasks));
    });

    on<RemoveTask>((event, emit) {
      final updatedTasks =
          state.tasks.where((task) => task.id != event.id).toList();
      emit(TaskLoaded(updatedTasks));
    });

    on<UpdateTask>((event, emit) {
      final updatedTasks = state.tasks.map((task) {
        if (task.id == event.id) {
          return task.copyWith(
              title: event.title, description: event.description);
        }
        return task;
      }).toList();
      emit(TaskLoaded(updatedTasks));
    });
  }
}
