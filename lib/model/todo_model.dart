import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final bool isDone;
  @HiveField(4)
  final bool isArchived;

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "date": date.toIso8601String(),
      "isDone": isDone,
      "isArchived": isArchived,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json["title"],
      description: json["description"],
      date: DateTime.parse(json["date"]),
      isDone: json["isDone"].toLowerCase() == 'true',
      isArchived: json["isArchived"].toLowerCase() == 'true',
    );
  }

  const TodoModel(
      {required this.title,
      required this.description,
      required this.date,
      required this.isDone,
      required this.isArchived});
}
