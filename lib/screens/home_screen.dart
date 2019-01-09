import 'package:flutter/material.dart';
import 'dart:math';

import '../classes/folder.dart';
import '../classes/todo.dart';

import '../widgets/todo_list.dart';
import '../widgets/folder_item.dart';
import '../widgets/list_header.dart';
import '../widgets/folder_list.dart';

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
    FolderItem(Folder('Folder 1',
        <Todo>[Todo('Todo 1', DateTime.now(), 'This is an example todo')])),
    FolderItem(Folder('Folder 2', <Todo>[
      Todo('Todo 2', DateTime.now(), 'This is another example todo')
    ])),
    FolderItem(Folder('Folder 3', <Todo>[
      Todo('Todo 3', DateTime.now(), 'This is another example todo')
    ])),
    FolderItem(Folder('Folder 4', <Todo>[
      Todo('Todo 4', DateTime.now(), 'This is another example todo')
    ])),
  ];

  void addFolder() {
    setState(() {
      int folderNum = random.nextInt(10);
      _items.insert(
          _items.length - 1, FolderItem(Folder('Folder $folderNum', <Todo>[])));
    });
    print(_items);
  }

  List<Todo> getAllTodos() {
    List<Todo> todos = <Todo>[];
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].getFolder().getAllTodos().length == 0) {
        continue;
      }
      todos.addAll(_items[i].getFolder().getAllTodos());
    }
    return todos;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
        ),
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              elevation: 10,
              onPressed: () {
                addFolder();
              },
            ),
            body: Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    ListHeader(
                        'To-Do Lists', EdgeInsets.fromLTRB(30.0, 30.0, 0, 0)),
                    FolderList(_items),
                    ListHeader('Upcoming To-Dos',
                        EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 0)),
                    TodoList(getAllTodos(), Alignment.center)
                  ],
                ))));
  }
}
