// class SubTask {
//   String title;
//   bool isDone;
//
//   SubTask({required this.title, this.isDone = false});
//
//   // Factory method to create a SubTask item from a JSON object
//   factory SubTask.fromJson(Map<String, dynamic> json) {
//     return SubTask(
//       title: json['title'],
//       isDone: json['isDone'],
//     );
//   }
//
//   // Method to convert a SubTask item to a JSON object
//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'isDone': isDone,
//     };
//   }
// }

class SubTask {
  String title;
  bool isDone;

  SubTask({required this.title, this.isDone = false});

  // Factory method to create a SubTask item from a JSON object
  factory SubTask.fromJson(Map<String, dynamic> json) {
    return SubTask(
      title: json['title'],
      isDone: json['isDone'],
    );
  }

  // Method to convert a SubTask item to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }
}

// Functions to handle a list of SubTask objects

// Add a new SubTask to the list
void addSubTask(List<SubTask> subTasks, SubTask task) {
  subTasks.add(task);
}

// Remove a SubTask by index
void removeSubTask(List<SubTask> subTasks, int index) {
  if (index >= 0 && index < subTasks.length) {
    subTasks.removeAt(index);
  }
}

// Update a SubTask at a specific index
void updateSubTask(List<SubTask> subTasks, int index, SubTask updatedTask) {
  if (index >= 0 && index < subTasks.length) {
    subTasks[index] = updatedTask;
  }
}

// Convert a list of SubTask objects to JSON
List<Map<String, dynamic>> subTaskListToJson(List<SubTask> subTasks) {
  return subTasks.map((task) => task.toJson()).toList();
}

// Create a list of SubTask objects from JSON
List<SubTask> subTaskListFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => SubTask.fromJson(json)).toList();
}


