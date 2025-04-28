import 'package:flutter/material.dart';

import '../model/sub_task.dart';
import '../model/todo.dart';

class SubTasksPage extends StatefulWidget {
  final ToDo todo;

  const SubTasksPage({Key? key, required this.todo}) : super(key: key);

  @override
  _SubTasksPageState createState() => _SubTasksPageState();
}

class _SubTasksPageState extends State<SubTasksPage> {
  // Controller for the subtask input field
  final subTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Display the main todo title in the app bar
        title: Text(
          widget.todo.todoText!,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Expanded widget to fill available space with the ListView
          Expanded(
            child: ListView.builder(
              // Number of subTasks in the main todo
              itemCount: widget.todo.subTasks.length,
              itemBuilder: (context, index) {
                final subTask = widget.todo.subTasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // background color of subtask
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 4.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      // the checkboxicon to mark the subtask as done or not
                      leading: Checkbox(
                        value: subTask.isDone,
                        onChanged: (value) {
                          setState(() {
                            subTask.isDone = value!;
                          });
                        },
                      ),
                      // display the title of the subtask
                      title: Text(
                        subTask.title,
                        style: TextStyle(
                          decoration: subTask.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      // Delete button to remove the subtask
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            widget.todo.subTasks.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input field and add button for new subtask
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: TextField(
                      //the Controller for subtasks input field
                      controller: subTaskController,
                      decoration: InputDecoration(
                        hintText: 'Add Subtask',
                      ),
                    ),
                  ),
                ),
                // button to add new subtask to the list
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (subTaskController.text.isNotEmpty) {
                        widget.todo.subTasks.add(
                          SubTask(
                            title: subTaskController.text,
                            isDone: false,
                          ),
                        );
                        // Clear the input field after adding
                        subTaskController.clear();
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // delete controller
  @override
  void dispose() {
    subTaskController.dispose();
    super.dispose();
  }
}
