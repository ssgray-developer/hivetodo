import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hivetodo/model/todo_model.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  static TodoCubit get(context) => BlocProvider.of(context);

  //controller
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  //date time picker
  var initialDate = DateTime.now();

  setDate(BuildContext context) {
    showDatePicker(
            context: context,
            currentDate: initialDate,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2030))
        .then((value) {
      if (value != null) {
        initialDate = value;
      }
      emit(SetDateState());
    });
  }

  List<TodoModel>? todosList = [];
  List<int>? keys = [];
  getBox() async {
    var box = await Hive.openBox<TodoModel>('todos');
    keys = [];
    keys = box.keys.cast<int>().toList();
    todosList = [];
    for (var key in keys!) {
      todosList!.add(box.get(key)!);
    }
    box.close();
    emit(GetBoxState());
  }

  addTodo(TodoModel todoModel) async {
    await Hive.openBox<TodoModel>('todos')
        .then((value) => value.add(todoModel))
        .then((value) => getBox());
    emit(AddToDoListState());
  }

  updateTodo(TodoModel todoModel) async {
    await Hive.openBox<TodoModel>('todos').then((value) {
      final Map<dynamic, TodoModel> todoMap = value.toMap();
      dynamic desiredKey;
      todoMap.forEach((key, value) {
        if (value.title == todoModel.title) {
          desiredKey = key;
        }
      });
      return value.put(desiredKey, todoModel);
    }).then((value) => getBox());
    emit(AddToDoListState());
  }

  deleteTodo(TodoModel todoModel) async {
    await Hive.openBox<TodoModel>('todos').then((value) {
      final Map<dynamic, TodoModel> todoMap = value.toMap();
      dynamic desiredKey;
      todoMap.forEach((key, value) {
        if (value.title == todoModel.title) {
          desiredKey = key;
        }
      });
      return value.delete(desiredKey);
    }).then((value) => getBox());
    emit(AddToDoListState());
  }

  clearController() {
    descriptionController.clear();
    titleController.clear();
  }

  int currentIndex = 0;
  setBottomIndex(int index) {
    currentIndex = index;
    emit(SetCurrentIndexAppState());
  }
}
