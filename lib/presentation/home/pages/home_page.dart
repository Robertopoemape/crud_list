import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/router/router.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                autoRouterPush(context, HomeBlocRoute());
              },
              child: Text('Bloc'),
            ),
            ElevatedButton(
              onPressed: () {
                autoRouterPush(context, HomeProviderRoute());
              },
              child: Text('provider'),
            ),
            ElevatedButton(
              onPressed: () {
                autoRouterPush(context, HomeRiverpodRoute());
              },
              child: Text('Riverpod'),
            ),
          ],
        ),
      ),
    );
  }
}
