
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/task_controller.dart';
// import 'edit_task_screen.dart';

// class SearchScreen extends StatelessWidget {
//   final TaskController taskController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Search Tasks"),
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (value) {
//                 // Update search query in TaskController
//                 taskController.searchQuery.value = value;
//               },
//               decoration: InputDecoration(
//                 labelText: "Search tasks",
//                 hintText: "Enter task title or description",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (taskController.filteredTasks.isEmpty) {
//                 return Center(child: Text("No matching tasks found."));
//               }
//               return ListView.builder(
//                 itemCount: taskController.filteredTasks.length,
//                 itemBuilder: (context, index) {
//                   final task = taskController.filteredTasks[index];
//                   return Card(
//                     elevation: 3,
//                     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     child: ListTile(
//                       title: Text(
//                         task.title,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Due: ${task.dueDate.toLocal()}"),
//                           Text("Priority: ${_priorityText(task.priority)}"),
//                         ],
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => taskController.deleteTask(index),
//                       ),
//                       onTap: () {
//                         // Navigate to EditTaskScreen and pass the task index
//                         Get.to(() => EditTaskScreen(taskIndex: index));
//                       },
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper function to display priority as text
//   String _priorityText(int priority) {
//     switch (priority) {
//       case 1:
//         return "High";
//       case 2:
//         return "Medium";
//       case 3:
//         return "Low";
//       default:
//         return "Undefined";
//     }
//   }
// }


// lib/views/search_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import 'edit_task_screen.dart';

class SearchScreen extends StatelessWidget {
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Tasks"),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                // Update search query in TaskController
                taskController.searchQuery.value = value;
              },
              decoration: InputDecoration(
                labelText: "Search tasks",
                hintText: "Enter task title or description",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              // Check if filteredTasks is empty
              if (taskController.filteredTasks.isEmpty) {
                return Center(child: Text("No matching tasks found."));
              }

              // Display matching tasks if available
              return ListView.builder(
                itemCount: taskController.filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = taskController.filteredTasks[index];
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
