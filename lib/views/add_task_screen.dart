// lib/views/add_task_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class AddTaskScreen extends StatelessWidget {
  final TaskController taskController = Get.find();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priorityController = TextEditingController();
  final dueDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
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
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  dueDateController.text = pickedDate.toString();
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                var task = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  priority: int.parse(priorityController.text),
                  dueDate: DateTime.parse(dueDateController.text),
                );
                taskController.addTask(task);
                Get.back();
              },
              child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
