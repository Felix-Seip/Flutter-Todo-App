import 'package:flutter/material.dart';

import '../classes/folder.dart';
import '../classes/todo.dart';
import '../classes/enums.dart';

import '../widgets/lists/todo_list.dart';
import '../widgets/lists/folder_list.dart';
import '../widgets/list_header.dart';
import '../widgets/lists/items/folder_item.dart';

import '../screens/add_folder_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    //Dummy data only
    for (int i = 0; i < _items.length; i++) {
      _items[i].getFolder().addTodo(Todo('Todo $i', DateTime.now(),
          'This is an example todo', _items[i].getFolder()));
    }

    super.initState();
  }

  List<FolderItem> _items = <FolderItem>[
    FolderItem(Folder('Folder 1', <Todo>[], "assets/wallpaper.jpg")),
    FolderItem(Folder('Folder 2', <Todo>[], "assets/wallpaper.jpg")),
    FolderItem(Folder('Folder 3', <Todo>[], "assets/wallpaper.jpg")),
    FolderItem(Folder('Folder 4', <Todo>[], "assets/wallpaper.jpg")),
  ];

  List<Widget> _appBarActions = <Widget>[];

  List<Todo> _getAllUpcomingTodos({int distanceBetweenDates = 7}) {
    List<Todo> todos = <Todo>[];
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].getFolder().getAllTodos().length == 0) {
        continue;
      }

      for (int j = 0; j < _items[i].getFolder().getAllTodos().length; j++) {
        if (_items[i]
                .getFolder()
                .getAllTodos()[j]
                .getCompletionTime()
                .difference(DateTime.now()) <
            Duration(days: distanceBetweenDates)) {
          todos.add(_items[i].getFolder().getAllTodos()[j]);
        }
      }
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

  void _handleTodoItemButtons(Todo todo, TodoActions todoAction) {
    String snackBarMessage = '';

    setState(() {
      switch (todoAction) {
        case TodoActions.MarkCompleted:
          todo.setTodoStatus(TodoStatus.Complete);
          snackBarMessage = 'Marked to-do ${todo.getTitle()} as completed';
          break;
        case TodoActions.Delete:
          todo.getParentFolder().deleteTodo(todo);
          snackBarMessage = 'Deleted to-do ${todo.getTitle()}';
          break;
      }
    });

    _showSnackBar(todo, snackBarMessage, todoAction);
  }

  void _showSnackBar(Todo todo, String message, TodoActions todoAction) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            switch (todoAction) {
              case TodoActions.MarkCompleted:
                todo.setTodoStatus(TodoStatus.Uncomplete);
                break;
              case TodoActions.Delete:
                todo.getParentFolder().addTodo(todo);
                break;
            }
          });
        },
      ),
    );

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    Scaffold.of(context).showSnackBar(snackBar);
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
              TodoList(_getAllUpcomingTodos(distanceBetweenDates: 7), Alignment.center, _handleTodoItemButtons)
            ],
          ),
        ),
      ),
    );
  }
}
