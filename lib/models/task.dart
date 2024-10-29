// class Task {
//   String title;
//   String description;
//   int priority; // 1 for High, 2 for Medium, 3 for Low
//   DateTime dueDate;

//   Task({
//     required this.title,
//     required this.description,
//     required this.priority,
//     required this.dueDate,
//   });
// }


// lib/models/task.dart
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  int priority;

  @HiveField(3)
  DateTime dueDate;

  Task({
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
  });
}
