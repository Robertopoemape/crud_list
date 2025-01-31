import 'package:flutter/material.dart';

import '../models/task_model.dart';

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
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
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
