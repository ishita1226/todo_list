import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final TaskController taskController = Get.find();
  final int taskIndex; // Index of the task to be edited

  // Constructor to accept the task index from the HomeScreen
  EditTaskScreen({Key? key, required this.taskIndex}) : super(key: key);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priorityController = TextEditingController();
  final dueDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the existing task details
    final task = taskController.tasks[taskIndex];

    // Initialize text controllers with existing task details
    titleController.text = task.title;
    descriptionController.text = task.description;
    priorityController.text = task.priority.toString();
    dueDateController.text = task.dueDate.toIso8601String().substring(0, 10);

    return Scaffold(
      appBar: AppBar(title: Text("Edit Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: priorityController,
              decoration: InputDecoration(labelText: "Priority (1-3)"),
            ),
            TextField(
              controller: dueDateController,
              decoration: InputDecoration(labelText: "Due Date (YYYY-MM-DD)"),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: task.dueDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  dueDateController.text = pickedDate.toIso8601String().substring(0, 10);
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                var updatedTask = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  priority: int.parse(priorityController.text),
                  dueDate: DateTime.parse(dueDateController.text),
                );
                taskController.editTask(taskIndex, updatedTask);
                Get.back();
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
