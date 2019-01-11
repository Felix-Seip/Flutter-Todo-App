import 'package:flutter/material.dart';
import 'dart:math';

import '../classes/folder.dart';
import '../classes/todo.dart';


import '../widgets/todo_list.dart';
import '../widgets/folder_item.dart';
import '../widgets/list_header.dart';
import '../widgets/folder_list.dart';

import '../screens/add_folder_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  Random random;

  @override
  void initState() {
    super.initState();
    random = Random();
  }

  List<FolderItem> _items = <FolderItem>[
    FolderItem(Folder(
        'Folder 1',
        <Todo>[Todo('Todo 1', DateTime.now(), 'This is an example todo')],
        "assets/wallpaper.jpg")),
    FolderItem(Folder(
        'Folder 2',
        <Todo>[Todo('Todo 2', DateTime.now(), 'This is another example todo')],
        "assets/wallpaper.jpg")),
    FolderItem(Folder(
        'Folder 3',
        <Todo>[Todo('Todo 3', DateTime.now(), 'This is another example todo')],
        "assets/wallpaper.jpg")),
    FolderItem(Folder(
        'Folder 4',
        <Todo>[Todo('Todo 4', DateTime.now(), 'This is another example todo')],
        "assets/wallpaper.jpg")),
  ];

  List<Widget> _appBarActions = <Widget>[];

  List<Todo> _getAllTodos() {
    List<Todo> todos = <Todo>[];
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].getFolder().getAllTodos().length == 0) {
        continue;
      }
      todos.addAll(_items[i].getFolder().getAllTodos());
    }
    return todos;
  }

  void _addFolder() async {
    final Folder folder = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFolderScreen()),
    );
    if (folder != null) {
      setState(() {
        _items.add(FolderItem(folder));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('To-Do App'),
          actions: _appBarActions,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          elevation: 10,
          onPressed: () {
            _addFolder();
          },
          backgroundColor: Color.fromARGB(255, 34, 116, 165),
        ),
        body: Container(
          decoration: new BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              ListHeader('To-Do Lists', EdgeInsets.fromLTRB(30.0, 30.0, 0, 0)),
              FolderList(_items),
              ListHeader(
                  'Upcoming To-Dos', EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 0)),
              TodoList(_getAllTodos(), Alignment.center)
            ],
          ),
        ),
      ),
    );
  }
}
