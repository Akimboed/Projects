// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDo> todoslist = []; // This list stores all the ToDo items
  final todoController =
      TextEditingController(); // Controller for the TextField
  List<ToDo> findToDo = []; // This list is used for filtering the ToDo items

  @override
  void initState() {
    super.initState();
    _loadToDoList(); // Load the saved to-do list when the app starts
  }

  // Function to load to-do list from SharedPreferences
  Future<void> _loadToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');
    if (todosString != null) {
      final List<dynamic> decoded = jsonDecode(todosString);
      setState(() {
        todoslist = decoded.map((item) => ToDo.fromJson(item)).toList();
        findToDo = todoslist;
      });
    }
  }

  // Function to save the to-do list to SharedPreferences
  Future<void> _saveToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded =
        jsonEncode(todoslist.map((todo) => todo.toJson()).toList());
    prefs.setString('todos', encoded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: Lottie.network(
                  "https://lottie.host/7eef3652-e7f2-49de-b9f6-142b21da869c/iAAqoB4dp6.json",
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.settings),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ],
                backgroundColor:
                    Colors.transparent, // Set background color to transparent
                centerTitle: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background Image
                      Image.network(
                        'https://i.pinimg.com/564x/4b/0e/04/4b0e04e83c0e8f49be53e8f917cfd494.jpg', // Replace with your image URL
                        fit: BoxFit.cover,
                      ),
                      // Container for Search TextField
                      Container(
                        padding: EdgeInsets.only(
                          top: 220,
                          bottom: 10,
                          right: 5,
                          left: 5,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(
                                    0.7), // Set background color with opacity
                          ),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) => runFilter(value),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.search,
                                  size: 25,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: "Search",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        color: Colors
                            .transparent, // Transparent container to avoid overlay issues
                      ),
                    ],
                  ),
                ),
                title: Text(
                  "YO-DO TO DO APP",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                expandedHeight: 230,
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "Your ToDo's",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          color: Colors.indigo[900],
                        ),
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(height: 5),
                    // Display each ToDo item
                    for (ToDo todoo in findToDo)
                      ToDoItem(
                        todo: todoo,
                        onToDoChanged: handleToDoChange,
                        onDeleteItem: deleteToDoItem,
                      ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 17, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: todoController,
                      decoration: InputDecoration(
                        hintText: 'Add new ToDo Item',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 15, bottom: 20),
                  child: ElevatedButton(
                    child: Text(
                      "+",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: () {
                      _addToDoItem(todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: Size(40, 40),
                      elevation: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to handle changes to a ToDo item
  void handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    _saveToDoList(); // Save the to-do list whenever an item is changed
  }

  // Function to delete a ToDo item
  void deleteToDoItem(String id) {
    setState(() {
      todoslist.removeWhere((item) => item.id == id);
    });
    _saveToDoList(); // Save the to-do list whenever an item is deleted
  }

  // Function to add a new ToDo item
  void _addToDoItem(String toDo) {
    setState(() {
      todoslist.add(ToDo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    todoController.clear();
    _saveToDoList(); // Save the to-do list whenever a new item is added
  }

  // Function to filter the ToDo list based on the entered keyword
  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoslist;
    } else {
      results = todoslist
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      findToDo = results;
    });
  }
}
