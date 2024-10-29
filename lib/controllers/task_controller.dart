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

  void addTask(Task task) {
    tasks.add(task);
    tasksBox.add(task); // Add task to Hive box
    _scheduleTaskNotification(task);
    filterTasks();
  }


  void editTask(int index, Task updatedTask) {
  final taskKey = tasks[index].key as int;
  tasksBox.put(taskKey, updatedTask);
  tasks[index] = updatedTask;
  _scheduleTaskNotification(updatedTask);
  filterTasks();
}


  void deleteTask(int index) {
    notificationService.cancelNotification(tasks[index].key as int);
    tasks[index].delete(); // Delete task from Hive
    tasks.removeAt(index);
    filterTasks();
  }


   void _scheduleTaskNotification(Task task) {
    if (task.dueDate.isAfter(DateTime.now())) {
      notificationService.scheduleNotification(
        id: task.key as int, // Unique ID for the notification
        title: "Task Reminder: ${task.title}",
        body: "Due on ${task.dueDate.toLocal()}",
        scheduledDate: task.dueDate,
      );
    }
  }

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
