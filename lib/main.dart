import 'dart:developer';

import 'package:crud_list/data/local/task_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart' as provider;

import 'models/task_model.dart';
import 'presentation/flutter_bloc/blocs/task_bloc.dart';
import 'core/router/router.dart';
import 'presentation/flutter_provider/providers/task_provider.dart';

final appRouter = MicroAppRouter();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());

    await TaskStorage().init();
    log('Hive inicializado correctamente', name: 'main');
  } catch (e, stackTrace) {
    log('Error al inicializar Hive: $e',
        name: 'main', error: e, stackTrace: stackTrace);
    return;
  }

  runApp(
    ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(create: (_) => TaskProvider()),
        ],
        child: BlocProvider(
          create: (context) => TaskBloc(),
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.delegate(
        navigatorObservers: () => [],
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
