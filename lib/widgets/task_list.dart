// lib/widgets/task_list.dart

import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(String) toggleTaskCompletion;
  final Function(String, String, String) editTask;
  final Function(String) deleteTask;

  const TaskList({
    super.key,
    required this.tasks,
    required this.toggleTaskCompletion,
    required this.editTask,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final titleController = TextEditingController(text: tasks[index].title);
        final descriptionController = TextEditingController(text: tasks[index].description);

        return ListTile(
          title: Text(
            tasks[index].title,
            style: TextStyle(
              decoration: tasks[index].isCompleted
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          subtitle: Text(tasks[index].description),
          trailing: Checkbox(
            value: tasks[index].isCompleted,
            onChanged: (value) {
              toggleTaskCompletion(tasks[index].id);
            },
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Edit Task'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: 'Task Title',
                        ),
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Task Description',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        editTask(
                          tasks[index].id,
                          titleController.text,
                          descriptionController.text,
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        deleteTask(tasks[index].id);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
