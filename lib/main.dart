import 'dart:developer';

import 'package:crud_list/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

import 'core/router/router.dart';
import 'presentation/flutter_bloc/blocs/task_cubit.dart';
import 'presentation/flutter_provider/providers/task_provider.dart';

final appRouter = MicroAppRouter();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initDependencies();

    log('Hive inicializado correctamente', name: 'main');

    runApp(
      ProviderScope(
        child: provider.MultiProvider(
          providers: [
            provider.ChangeNotifierProvider(
              create: (_) => TaskProvider(),
            ),
          ],
          child: BlocProvider(
            create: (context) => TaskCubit(),
            child: const MyApp(),
          ),
        ),
      ),
    );
  } catch (e, stackTrace) {
    log('Error al inicializar Hive: $e',
        name: 'main', error: e, stackTrace: stackTrace);
  }
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
