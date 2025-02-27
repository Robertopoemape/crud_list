import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/models/task_model.dart';
import '../data/sources/task_storage.dart';
import '../domain/repositories/task_repository.dart';
import '../domain/usecases/add_task_usecase.dart';
import '../domain/usecases/get_task_usecase.dart';
import 'data/repository/task_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Inicializa Hive y registra el adaptador.
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());

  // Registra las fuentes de datos para cada enfoque.
  final taskStorageProvider = TaskStorage('tasks_provider');
  final taskStorageRiverpod = TaskStorage('tasks_riverpod');
  final taskStorageBloc = TaskStorage('tasks_bloc');

  // Inicializa cada TaskStorage.
  await Future.wait([
    taskStorageProvider.init(),
    taskStorageRiverpod.init(),
    taskStorageBloc.init(),
  ]);

  // Registra cada TaskStorage en get_it, usando instanceName para diferenciarlos.
  getIt.registerSingleton<TaskStorage>(taskStorageProvider,
      instanceName: 'provider');
  getIt.registerSingleton<TaskStorage>(taskStorageRiverpod,
      instanceName: 'riverpod');
  getIt.registerSingleton<TaskStorage>(taskStorageBloc, instanceName: 'bloc');

  // Registra los repositorios correspondientes a cada fuente de datos.
  final taskRepositoryProvider =
      TaskRepositoryImpl(taskStorage: taskStorageProvider);
  final taskRepositoryRiverpod =
      TaskRepositoryImpl(taskStorage: taskStorageRiverpod);
  final taskRepositoryBloc = TaskRepositoryImpl(taskStorage: taskStorageBloc);

  getIt.registerSingleton<TaskRepository>(taskRepositoryProvider,
      instanceName: 'provider');
  getIt.registerSingleton<TaskRepository>(taskRepositoryRiverpod,
      instanceName: 'riverpod');
  getIt.registerSingleton<TaskRepository>(taskRepositoryBloc,
      instanceName: 'bloc');

  // Registra los casos de uso para cada enfoque.
  // Para Provider:
  getIt.registerFactory<GetTask>(
      () => GetTask(getIt<TaskRepository>(instanceName: 'provider')),
      instanceName: 'providerGetTask');
  getIt.registerFactory<AddTaskUseCase>(
      () => AddTaskUseCase(getIt<TaskRepository>(instanceName: 'provider')),
      instanceName: 'providerAddTask');

  // Para Riverpod:
  getIt.registerFactory<GetTask>(
      () => GetTask(getIt<TaskRepository>(instanceName: 'riverpod')),
      instanceName: 'riverpodGetTask');
  getIt.registerFactory<AddTaskUseCase>(
      () => AddTaskUseCase(getIt<TaskRepository>(instanceName: 'riverpod')),
      instanceName: 'riverpodAddTask');

  // Para Bloc:
  getIt.registerFactory<GetTask>(
      () => GetTask(getIt<TaskRepository>(instanceName: 'bloc')),
      instanceName: 'blocGetTask');
  getIt.registerFactory<AddTaskUseCase>(
      () => AddTaskUseCase(getIt<TaskRepository>(instanceName: 'bloc')),
      instanceName: 'blocAddTask');
}
