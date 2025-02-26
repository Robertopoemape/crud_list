import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../core/core.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Manejadores de estado',
          style: TextStyle(
            fontSize: ds20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        elevation: 4,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              onPressed: () {
                autoRouterPush(context, HomeBlocRoute());
              },
              label: 'Bloc',
            ),
            Button(
              onPressed: () {
                autoRouterPush(context, HomeProviderRoute());
              },
              label: 'Provider',
            ),
            Button(
              onPressed: () {
                autoRouterPush(context, HomeRiverpodRoute());
              },
              label: 'Riverpod',
            ),
          ],
        ),
      ),
    );
  }
}
