part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class SetCurrentIndexAppState extends TodoState {}

class SetDateState extends TodoState {}

class GetBoxState extends TodoState {}

class AddToDoListState extends TodoState {}
