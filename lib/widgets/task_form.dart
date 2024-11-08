// lib/widgets/task_form.dart

import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  final Function(String, String) addTask;  // Callback for adding tasks

  const TaskForm({super.key, required this.addTask});

  @override
  TaskFormState createState() => TaskFormState();
}

class TaskFormState extends State<TaskForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Task Title',
            ),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Task Description',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Using the passed callback to add a task
              widget.addTask(
                _titleController.text,
                _descriptionController.text,
              );
              // Clear the text fields after submission
              _titleController.clear();
              _descriptionController.clear();
            },
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
