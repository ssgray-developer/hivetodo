import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivetodo/cubit/todo_cubit.dart';
import 'package:hivetodo/model/todo_model.dart';
import 'package:hivetodo/widgets/todo_tile.dart';

class AllTodosScreen extends StatelessWidget {
  const AllTodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
      var cubit = TodoCubit.get(context);
      List<TodoModel>? todosList = [];
      for (var item in cubit.todosList!) {
        if (!item.isArchived && !item.isDone) {
          todosList.add(item);
        }
      }
      return todosList.isEmpty
          ? const Center(
              child: Text('Todo list is empty.'),
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
