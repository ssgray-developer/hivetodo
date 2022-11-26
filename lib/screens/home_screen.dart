import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivetodo/cubit/todo_cubit.dart';
import 'package:hivetodo/model/todo_model.dart';
import 'package:hivetodo/screens/all_todos_screen.dart';
import 'package:hivetodo/screens/archives_screen.dart';
import 'package:hivetodo/screens/done_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Widget> list = const [
    AllTodosScreen(),
    DoneScreen(),
    ArchivesScreen(),
  ];

  final List<String> title = const [
    "AllTodos",
    "Done",
    "Archives",
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      builder: (BuildContext context, state) {
        var cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(title[cubit.currentIndex]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Todo Details'),
                        content: BlocBuilder<TodoCubit, TodoState>(
                          builder: (context, state) {
                            return Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: cubit.titleController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Title',
                                      hintText: 'Enter Title',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'hey bro dont leave it empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  TextFormField(
                                    controller: cubit.descriptionController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Description',
                                      hintText: 'Enter Description',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'hey bro dont leave it empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        maximumSize: Size.infinite),
                                    onPressed: () {
                                      cubit.setDate(context);
                                    },
                                    icon: const Icon(Icons.date_range),
                                    label: Text(DateFormat.yMMMEd()
                                        .format(cubit.initialDate)),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                cubit.clearController();
                              },
                              child: const Text('Cancel')),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton.icon(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.addTodo(TodoModel(
                                      title: cubit.titleController.text,
                                      description:
                                          cubit.descriptionController.text,
                                      date: cubit.initialDate,
                                      isDone: false,
                                      isArchived: false));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        '${cubit.titleController.text} added'),
                                    backgroundColor: Colors.green.shade500,
                                  ));
                                  Navigator.pop(context);
                                  cubit.clearController();
                                }
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Add'))
                        ],
                      ));
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.setBottomIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done'),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Archived')
            ],
          ),
          body: list[cubit.currentIndex],
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
