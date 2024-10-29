# Todo List App Documentation
## Overview
The Todo List App is a task management application developed using Flutter and Dart. It allows users to create, manage, prioritize, and receive notifications for their tasks. With a user-friendly interface and features such as push notifications, task reminders, search, and persistent local storage, this app aims to make task management efficient and convenient.
## Key Features:
•	Add, Edit, and Delete Tasks: Users can create, update, and remove tasks as needed.
•	Task Prioritization: Tasks can be prioritized as High, Medium, or Low.
•	Reminders and Push Notifications: Users are notified of tasks 15 hours prior their due dates.
•	Search Functionality: A dedicated search screen enables users to filter tasks by keywords.
•	Persistent Storage: Tasks are stored locally on the device using Hive, ensuring data is retained across sessions.
•	Sorting Functionality: Tasks can be sorted by due date and priority order (high to low) for better user experience.
## Objectives
The main objectives of this app are:
•	To help users efficiently organize and prioritize their tasks.
•	To provide timely reminders for upcoming tasks.
•	To ensure a smooth user experience through a responsive and interactive UI.
## Requirements and Setup
### Prerequisites
•	Flutter SDK: Flutter should be installed on your system.
•	Hive for Local Storage: Used for persistent task data storage.
•	GetX for State Management: Simplifies the management of app state.
•	flutter_local_notifications: Used to implement local push notifications for task reminders.
### Installation
1.	Clone the project from the GitHub repository.
git clone https://github.com/ishita1226/todo_list.git
2.	Navigate to the project directory.
cd todo_list_app
3.	Install the required dependencies.
flutter pub get
4.	Run the app.
flutter run
## Project Architecture
### Architecture Pattern: MVVM
The app follows the Model-View-View Model (MVVM) architecture, which helps separate business logic from UI components, making the code more manageable and testable.
•	Model: Defines the structure of the Task data model.
•	View: Contains UI screens such as HomeScreen, AddTaskScreen, EditTaskScreen, and SearchScreen.
•	ViewModel (Controller): Uses GetX to manage the app state. The TaskController handles CRUD operations, notification scheduling, and search functionality.
### Directory Structure
lib/
├── models/               # Data model definitions
│   └── task.dart         # Task model with Hive annotations
├── views/                # UI screens
│   ├── home_screen.dart  # Home screen with task list and sorting
│   ├── add_task_screen.dart   # Screen for adding new tasks
│   ├── edit_task_screen.dart  # Screen for editing existing tasks
│   └── search_screen.dart     # Search screen with keyword filtering
├── controllers/          # State management and business logic
│   └── task_controller.dart  # Controller for managing task state and notifications
│
└── services/
    └── notification_service.dart  # Handles scheduling and cancelling notifications
### Core Components
1. Task Model
•	Located in models/tas
•	k.dart.
•	Implements Hive’s @HiveType and @HiveField annotations for local storage.
2. TaskController
•	Found in controllers/task_controller.dart.
•	Manages all task-related operations (add, edit, delete) and handles state with GetX.
•	Manages notification scheduling for due tasks and the search filter for SearchScreen.
3. NotificationService
•	Located in services/notification_service.dart.
•	Uses flutter_local_notifications to schedule, display, and cancel local notifications.
•	Integrates with the timezone package to handle time-specific notifications correctly.
4. UI Screens
•	HomeScreen: Lists all tasks with options to sort by priority or due date.
•	AddTaskScreen: Allows the user to create new tasks with title, description, priority, and due date.
•	EditTaskScreen: Allows the user to update existing task details.
•	SearchScreen: Enables keyword-based search to display only matching tasks.
State Management
•	GetX: Used for reactive state management. The TaskController controls all states for task creation, editing, deletion, and filtering.
Persistent Storage
•	Hive: The app uses Hive for local storage, allowing task data to persist between app sessions. Tasks are stored in a Hive box named tasksBox, ensuring fast, lightweight data access.
Push Notifications
•	flutter_local_notifications: Push notifications are scheduled for tasks close to their due dates. The NotificationService schedules and manages notifications using the task’s due date, so users are reminded even if the app is closed.

## Usage Guide
1.	Adding a Task:
o	Open the app and tap the Add button on the HomeScreen.
o	Enter task details such as title, description, priority, and due date.
o	Save the task, and it will appear on the home screen list.
2.	Editing a Task:
o	Tap on any task in the list on HomeScreen to navigate to EditTaskScreen.
o	Update task details and save changes. The updated task will replace the previous details.
3.	Deleting a Task:
o	Swipe left on a task item in the list or tap the delete icon to remove a task permanently.
4.	Searching for a Task:
o	Tap the Search button on the HomeScreen to go to SearchScreen.
o	Enter keywords in the search bar to filter tasks. Tasks matching the query will appear dynamically.
5.	Receiving Notifications:
o	Notifications will automatically appear for tasks due soon, based on their due date. Ensure notifications are enabled for the app in device settings.
## Post-Deployment Notes
1.	Data Persistence:
o	Tasks are stored using Hive, ensuring they persist even after the app is closed.
o	Modifications to the task schema may require migrations.
2.	Updating Notification Behavior:
o	Any changes to the notification timing or behavior can be managed in NotificationService. You can adjust the scheduleNotification method to change notification timing or customize notification settings.
3.	Customization and Maintenance:
o	UI Themes: Update themes in main.dart to customize colors or fonts.
o	Notification Service: Add support for different notification channels or intervals in NotificationService.
o	Hive Schema Changes: For any data model changes, ensure to increment the typeId in the model and handle migrations accordingly.
## Versioning
The app uses Git for version control. Ensure regular commits for changes and maintain clear commit messages to document progress and updates.
## Conclusion
The Todo List App is a reliable, efficient tool for task management with a simple yet powerful user experience. Built with a responsive UI, persistent storage, and timely reminders, it meets the needs of users looking to manage their tasks efficiently.


