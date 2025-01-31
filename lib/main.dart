import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

import 'presentation/flutter_bloc/blocs/task_bloc.dart';
import 'core/router/router.dart';
import 'presentation/flutter_provider/providers/task_provider.dart';

final appRouter = MicroAppRouter();
void main() {
  runApp(
    ProviderScope(
      // Necesario para Riverpod
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(
              create: (_) => TaskProvider()), // Provider
        ],
        child: BlocProvider(
          create: (context) => TaskBloc(), // Bloc
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
