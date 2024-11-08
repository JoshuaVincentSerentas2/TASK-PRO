// lib/screens/task_manager_home.dart

import 'package:flutter/material.dart';
import '../models/task.dart';  // Ensure this is correct
import '../services/task_service.dart';
import '../widgets/task_form.dart';
import '../widgets/task_list.dart';  // Ensure this is correct

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TaskService _taskService = TaskService();
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    tasks = _taskService.getTasks(); // Initialize tasks from service
  }

  void addTask(String title, String description) {
    setState(() {
      _taskService.addTask(title, description);
      tasks = _taskService.getTasks(); // Update tasks after adding
    });
  }

  void editTask(String id, String title, String description) {
    setState(() {
      _taskService.editTask(id, title, description);
      tasks = _taskService.getTasks(); // Update tasks after editing
    });
  }

  void deleteTask(String id) {
    setState(() {
      _taskService.deleteTask(id);
      tasks = _taskService.getTasks(); // Update tasks after deleting
    });
  }

  void toggleTaskCompletion(String id) {
    setState(() {
      _taskService.toggleTaskCompletion(id);
      tasks = _taskService.getTasks(); // Update tasks after toggling
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: Column(
        children: [
          TaskForm(
            addTask: addTask,
          ),
          Expanded(
            child: TaskList(
              tasks: tasks,
              toggleTaskCompletion: toggleTaskCompletion,
              editTask: editTask,
              deleteTask: deleteTask,
            ),
          ),
        ],
      ),
    );
  }
}
