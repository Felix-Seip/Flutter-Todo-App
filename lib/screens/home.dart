import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/folder_item.dart';
import '../classes/folder.dart';
import '../widgets/todo_item.dart';
import '../classes/todo.dart';

import '../widgets/list_header.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

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

  void addFolder() {
    setState(() {
      int folderNum = random.nextInt(10);
      _items.insert(
          _items.length - 1, FolderItem(Folder('Folder $folderNum', <Todo>[])));
    });
    print(_items);
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
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            height: 200.0,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _items.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    child: _items[index],
                                    onTap: () {
                                      print('tapped $index');
                                    },
                                  );
                                }))),
                    ListHeader('Upcoming To-Dos',
                        EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 0)),
                    Align(
                        alignment: Alignment.center,
                        child: Expanded(
                            child: Container(
                                margin: EdgeInsets.all(20.0),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: getAllTodos().length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        child:
                                            new TodoItem(getAllTodos()[index]),
                                        onTap: () {
                                          print('tapped $index');
                                        },
                                      );
                                    }))))
                  ],
                ))));
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
}
