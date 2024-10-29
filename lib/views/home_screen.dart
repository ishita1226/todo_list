// lib/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo List"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Priority') {
                taskController.sortTasksByPriority();
              } else if (value == 'Due Date') {
                taskController.sortTasksByDueDate();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Priority',
                child: Text('Sort by Priority'),
              ),
              const PopupMenuItem<String>(
                value: 'Due Date',
                child: Text('Sort by Due Date'),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (taskController.tasks.isEmpty) {
          return Center(child: Text("No tasks available. Add new tasks!"));
        }
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Due: ${task.dueDate.toLocal()}"),
                    Text("Priority: ${_priorityText(task.priority)}"),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => taskController.deleteTask(index),
                ),
                onTap: () {
                  // Navigate to EditTaskScreen and pass the task index
                  Get.to(() => EditTaskScreen(taskIndex: index));
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "addTask",
            child: Icon(Icons.add),
            onPressed: () {
              // Navigate to AddTaskScreen
              Get.to(() => AddTaskScreen());
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "searchTask",
            child: Icon(Icons.search),
            onPressed: () {
              // Navigate to SearchScreen
              Get.to(() => SearchScreen());
            },
          ),
        ],
      ),
    );
  }

  // Helper function to display priority as text
  String _priorityText(int priority) {
    switch (priority) {
      case 1:
        return "High";
      case 2:
        return "Medium";
      case 3:
        return "Low";
      default:
        return "Undefined";
    }
  }
}
