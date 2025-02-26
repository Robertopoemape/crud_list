import 'package:flutter/material.dart';

import '../core/core.dart';
import '../data/models/task_model.dart';

class CardList extends StatelessWidget {
  const CardList({
    required this.listTask,
    required this.itemBuilder,
    super.key,
  });

  final List<TaskModel> listTask;

  final Widget Function(BuildContext context, TaskModel task) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: ds8),
        itemCount: listTask.length,
        itemBuilder: (context, index) => itemBuilder(
              context,
              listTask[index],
            ));
  }
}
