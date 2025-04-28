// ignore_for_file: prefer_const_constructors


import 'package:final_assingment2/widgets/sub_tasks_page.dart';
import 'package:flutter/material.dart';

import '../model/todo.dart';


class ToDoItem extends StatelessWidget {
  // This class represents an individual ToDo item in the list
  final ToDo todo; // ToDo item
  // Function to handle changes to the ToDo item
  final Function onToDoChanged;
  // Function to handle deletion of the ToDo item
  final Function onDeleteItem;

  ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding for the ListTile
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 8),
      child: ListTile(
        // When the ListTile is tapped, navigate to the SubTasksPage
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubTasksPage(todo: todo),
            ),
          );
        },
        // Shape of the ListTile
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // Background color of the ListTile
        tileColor: Colors.indigo[900],
        // Text for the ToDo item
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.secondary,
            // Strike through the text if the ToDo item is done
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
            fontSize: 25,
          ),
        ),
        // Delete button at the end of the ListTile
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(5),
          ),
          // Icon button to delete the ToDo item
          child: IconButton(
            onPressed: () {
              onDeleteItem(todo.id);
            },
            iconSize: 20,
            icon: Icon(Icons.delete),
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
