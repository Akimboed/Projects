// class ToDo {
//   String? id;
//   String? todoText;
//   bool isDone;

//   ToDo({required this.id, required this.todoText, this.isDone = false});
//   static List<ToDo> todoList() {
//     return [
//       ToDo(id: '01', todoText: 'This is finished', isDone: true),
//       ToDo(id: '02', todoText: 'Make build plan', isDone: false),
//       ToDo(id: '03', todoText: 'how did you do that?', isDone: false),
//       ToDo(id: '04', todoText: 'Big Body GLE ', isDone: true),
//       ToDo(id: '05', todoText: 'DI GYAL BATTY BIG YF', isDone: true),
//     ];
//   }
// }


import 'package:final_assingment2/model/sub_task.dart';

class ToDo {
  String? id;
  String? todoText;
  bool isDone;
  List<SubTask> subTasks;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
    this.subTasks = const [],
  });

  // Factory method to create a ToDo item from a JSON object
  factory ToDo.fromJson(Map<String, dynamic> json) {
    var subTasksJson = json['subTasks'] as List? ?? [];
    List<SubTask> subTasksList = subTasksJson
        .map((subTaskJson) => SubTask.fromJson(subTaskJson))
        .toList();

    return ToDo(
      id: json['id'],
      todoText: json['todoText'],
      isDone: json['isDone'],
      subTasks: subTasksList,
    );
  }

  // Method to convert a ToDo item to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'isDone': isDone,
      'subTasks': subTasks.map((subTask) => subTask.toJson()).toList(),
    };
  }

  // Static method to create an initial list of ToDo items (example usage)
  static List<ToDo> todoList() {
    return [];
  }
}
