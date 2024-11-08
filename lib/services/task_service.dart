// lib/services/task_service.dart

import '../models/task.dart';

class TaskService {
  // A mock task list to simulate a database
  final List<Task> _tasks = [
    Task(id: '1', title: 'Learn Flutter', description: 'Study Flutter framework'),
    Task(id: '2', title: 'Build App', description: 'Create a new Flutter app'),
  ];

  List<Task> getTasks() {
    return _tasks;
  }

  void addTask(String title, String description) {
    final newTask = Task(
      id: DateTime.now().toString(),  // Generate a unique ID using current time
      title: title,
      description: description,
    );
    _tasks.add(newTask);
  }

  void editTask(String id, String title, String description) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.title = title;
    task.description = description;
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
  }

  void toggleTaskCompletion(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
  }
}
