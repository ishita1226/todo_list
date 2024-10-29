import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';
import '../main.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  var filteredTasks = <Task>[].obs;
  var searchQuery = ''.obs;

  late Box<Task> tasksBox;

  @override
  void onInit() {
    super.onInit();
    tasksBox = Hive.box<Task>('tasksBox');
    loadTasks();
    ever(searchQuery, (_) => filterTasks());
  }

  void loadTasks() {
    tasks.assignAll(tasksBox.values.toList());
    filterTasks();
  }

    // Method to schedule notifications for tasks due in the next 24 hours
  // void scheduleDueSoonNotifications() {
  //   final now = DateTime.now();
  //   final dueSoon = now.add(const Duration(hours: 24));

  //   // Iterate through tasks and schedule notifications for those due within 24 hours
  //   for (var task in tasks) {
  //     if (task.dueDate.isAfter(now) && task.dueDate.isBefore(dueSoon)) {
  //       notificationService.scheduleNotification(
  //         id: task.key as int,
  //         title: "Reminder: ${task.title}",
  //         body: "This task is due on ${task.dueDate.toLocal()}",
  //         scheduledDate: task.dueDate,
  //       );
  //     }
  //   }
  // }


  void scheduleDueSoonNotifications() {
  final now = DateTime.now();
  final dueSoon = now.add(const Duration(hours: 24));

  // Iterate through tasks and schedule notifications for those due within the next 24 hours
  for (var task in tasks) {
    if (task.dueDate.isAfter(now) && task.dueDate.isBefore(dueSoon)) {
      // Calculate the notification time as 15 hours before the due date
      DateTime notificationTime = task.dueDate.subtract(Duration(hours: 15));

      // If notification time is in the past (due in less than 15 hours), set it to trigger immediately
      if (notificationTime.isBefore(now)) {
        notificationTime = now.add(Duration(seconds: 10)); // For immediate notification if less than 15 hours left
      }

      // Schedule the notification at the calculated notification time
      notificationService.scheduleNotification(
        id: task.key as int,
        title: "Upcoming Task: ${task.title}",
        body: "Your task is due on ${task.dueDate.toLocal()}",
        scheduledDate: notificationTime,
      );
    }
  }
}


  void addTask(Task task) {
    tasks.add(task);
    tasksBox.add(task); // Add task to Hive box
    scheduleDueSoonNotifications();
    filterTasks();
  }


  void editTask(int index, Task updatedTask) {
  final taskKey = tasks[index].key as int;
  tasksBox.put(taskKey, updatedTask);
  tasks[index] = updatedTask;
  scheduleDueSoonNotifications();
  filterTasks();
}


  void deleteTask(int index) {
    notificationService.cancelNotification(tasks[index].key as int);
    tasks[index].delete(); // Delete task from Hive
    tasks.removeAt(index);
    filterTasks();
  }


  //  void _scheduleTaskNotification(Task task) {
  //   if (tas
  //k.dueDate.isAfter(DateTime.now())) {
  //     notificationService.scheduleNotification(
  //       id: task.key as int, // Unique ID for the notification
  //       title: "Task Reminder: ${task.title}",
  //       body: "Due on ${task.dueDate.toLocal()}",
  //       scheduledDate: task.dueDate,
  //     );
  //   }
  // }

  void sortTasksByPriority() {
    tasks.sort((a, b) => a.priority.compareTo(b.priority));
    filterTasks();
  }

  void sortTasksByDueDate() {
    tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    filterTasks();
  }

  void filterTasks() {
    if (searchQuery.value.isEmpty) {
      filteredTasks.clear();
    } else {
      filteredTasks.assignAll(
        tasks.where((task) =>
          task.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          task.description.toLowerCase().contains(searchQuery.value.toLowerCase())
        ),
      );
    }
  }
  @override
void dispose() {
  Hive.close();
  super.dispose();
}

}
