import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../model/todo_model.dart';
import '../widgets/todo_tile.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
      var cubit = TodoCubit.get(context);
      List<TodoModel>? todosList = [];
      for (var item in cubit.todosList!) {
        if (item.isDone) {
          todosList.add(item);
        }
      }
      return todosList.isEmpty
          ? const Center(
              child: Text('There are no tasks done.'),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return TodoTile(todoModel: todosList[index]);
              },
              itemCount: todosList.length,
              shrinkWrap: true,
            );
    });
  }
}
