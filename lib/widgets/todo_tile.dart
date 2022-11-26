import 'package:flutter/material.dart';
import 'package:hivetodo/cubit/todo_cubit.dart';
import 'package:hivetodo/model/todo_model.dart';
import 'package:intl/intl.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todoModel;
  const TodoTile({Key? key, required this.todoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);
    return ListTile(
      title: Row(
        children: [
          Text(todoModel.title),
          const Spacer(),
          IconButton(
            onPressed: () {
              cubit.deleteTodo(todoModel);
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
          IconButton(
            onPressed: () {
              cubit.updateTodo(TodoModel(
                  title: todoModel.title,
                  description: todoModel.description,
                  date: todoModel.date,
                  isDone: false,
                  isArchived: false));
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.amber,
          ),
          IconButton(
            onPressed: () {
              cubit.updateTodo(TodoModel(
                  title: todoModel.title,
                  description: todoModel.description,
                  date: todoModel.date,
                  isDone: true,
                  isArchived: false));
            },
            icon: const Icon(Icons.done),
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              cubit.updateTodo(TodoModel(
                  title: todoModel.title,
                  description: todoModel.description,
                  date: todoModel.date,
                  isDone: false,
                  isArchived: true));
            },
            icon: const Icon(Icons.book),
          )
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todoModel.description),
            Text(DateFormat.yMMMEd().format(todoModel.date)),
          ],
        ),
      ),
    );
  }
}
