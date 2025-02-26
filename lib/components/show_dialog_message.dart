import 'package:flutter/material.dart';

import '../core/core.dart';
import '../data/models/task_model.dart';

void showDialogMessage(
    {required BuildContext context,
    required TaskModel task,
    required VoidCallback onPressed}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Estas seguro que desea eliminar',
          style: TextStyle(
            fontSize: ds20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  autoRouterPop(context);
                },
                child: Text('No'),
              ),
            ),
            Expanded(
              child: ElevatedButton(onPressed: onPressed, child: Text('Si')),
            )
          ],
        ),
      );
    },
  );
}
