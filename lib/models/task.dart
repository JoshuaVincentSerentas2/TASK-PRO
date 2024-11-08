class Task {
  final String id;
  String title;  // Made mutable (non-final)
  String description;  // Made mutable (non-final)
  bool isCompleted;

  // Constructor
  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,  // Default value for isCompleted is false
  });

  // Override the equality operator to compare tasks by their unique id
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Task && other.id == id;
  }

  // Override the hashCode to ensure proper comparison in collections
  @override
  int get hashCode => id.hashCode;
}
