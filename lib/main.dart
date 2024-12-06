import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData(
        primaryColor: const Color(0xFF003DA5), // Ateneo blue
        textTheme: const TextTheme(
          bodyMedium: TextStyle( // Updated to bodyMedium
            fontFamily: 'Roboto',
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      home: TaskManagerHome(),
    );
  }
}

class TaskManagerHome extends StatefulWidget {
  const TaskManagerHome({super.key});

  @override
  _TaskManagerHomeState createState() => _TaskManagerHomeState();
}

class _TaskManagerHomeState extends State<TaskManagerHome> {
  final List<Map<String, dynamic>> tasks = [
    {'title': 'Pay Meralco Bill 💡', 'description': 'Due date: Oct 15, 2024. Pay via GCash or BPI.', 'completed': false},
    {'title': 'Renew Driver’s License 🚗', 'description': 'Visit LTO Buhangin. Bring necessary documents.', 'completed': false},
    {'title': 'Buy Groceries 🛒', 'description': 'SM Supermarket: rice, cooking oil, meat, and toiletries.', 'completed': false},
    {'title': 'Attend Barangay Meeting 🏢', 'description': 'Barangay Buhangin Community Hall at 4 PM.', 'completed': false},
  ];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int? editingIndex; // To keep track of the task being edited

  void addTask() {
    if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      setState(() {
        if (editingIndex == null) {
          tasks.add({
            'title': titleController.text,
            'description': descriptionController.text,
            'completed': false,
          });
        } else {
          tasks[editingIndex!] = {
            'title': titleController.text,
            'description': descriptionController.text,
            'completed': false,
          };
          editingIndex = null; // Reset editing index
        }
        titleController.clear();
        descriptionController.clear();
      });
    }
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void editTask(int index) {
    setState(() {
      titleController.text = tasks[index]['title'];
      descriptionController.text = tasks[index]['description'];
      editingIndex = index; // Set editingIndex to allow task update
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF003DA5), // Ateneo blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Form Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    'LIST THE DO!',
                    style: TextStyle(
                      color: Color(0xFF003DA5), // Ateneo blue
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Task Input Form
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Task Title',
                      filled: true,
                      fillColor: const Color(0xFFF9F9F9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003DA5)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Task Description',
                      filled: true,
                      fillColor: const Color(0xFFF9F9F9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003DA5)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: addTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003DA5), // Corrected to backgroundColor
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(editingIndex == null ? 'Add Task' : 'Update Task'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Task List
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      title: Text(
                        tasks[index]['title'],
                        style: const TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(tasks[index]['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: tasks[index]['completed'],
                            onChanged: (value) {
                              setState(() {
                                tasks[index]['completed'] = value!;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => editTask(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteTask(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
