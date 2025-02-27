import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/models/task_model.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/usecases/add_task_usecase.dart';
import '../../../domain/usecases/get_task_usecase.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTask _getTasksUseCase =
      GetIt.I<GetTask>(instanceName: "blocGetTask");
  final AddTaskUseCase _addTaskUseCase =
      GetIt.I<AddTaskUseCase>(instanceName: "blocAddTask");

  TaskCubit() : super(TaskInitial()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      final domainTasks = await _getTasksUseCase();
      final models =
          domainTasks.map((task) => TaskModel.fromDomain(task)).toList();
      emit(TaskLoaded(models));
    } catch (e) {
      emit(TaskError("Error al cargar tareas"));
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _addTaskUseCase(task);
      loadTasks();
    } catch (e) {
      emit(TaskError("Error al agregar la tarea"));
    }
  }

  void toggleTask(int id) {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final tasks = List<TaskModel>.from(currentState.tasks);
      final index = tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        tasks[index] =
            tasks[index].copyWith(isCompleted: !tasks[index].isCompleted);
        emit(TaskLoaded(tasks));
      }
    }
  }

  void removeTask(int id) {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final tasks = currentState.tasks.where((task) => task.id != id).toList();
      emit(TaskLoaded(tasks));
    }
  }

  void updateTask(int id, String title, String description) {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final tasks = List<TaskModel>.from(currentState.tasks);
      final index = tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        tasks[index] =
            tasks[index].copyWith(title: title, description: description);
        emit(TaskLoaded(tasks));
      }
    }
  }
}
