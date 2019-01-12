import 'package:flutter/material.dart';

import '../widgets/todo_item.dart';

import '../screens/add_todo_item_screen.dart';

import '../classes/app_bar_action.dart';
import '../classes/folder.dart';
import '../classes/todo.dart';
import '../classes/enums.dart';

class FolderScreen extends StatefulWidget {
  final Folder _folder;

  FolderScreen(this._folder);

  @override
  State<StatefulWidget> createState() {
    return _FolderScreenState();
  }
}

class _FolderScreenState extends State<FolderScreen> {
  final AppBarAction _addTodoAction =
      AppBarAction(title: 'Add', icon: Icons.add, action: Action.Add);

  final AppBarAction _editFolderAction =
      AppBarAction(title: 'Edit', icon: Icons.edit, action: Action.Edit);

  void _selectAppBarAction(AppBarAction action, BuildContext context) async {
    print(action.action);
    if (action.action == Action.Add) {
      //TODO: Change return type to a onScreenResult object that can hold more information
      final Todo todo = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddTodoItemScreen(widget._folder)),
      );
      if (todo != null) {
        setState(() {
          widget._folder.addTodo(todo);
        });
      }
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

    //TODO: Fix bug where the snackbar is not showing since it does not find the scaffold
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> _todos = widget._folder.getAllTodos();

    return Scaffold(
      key: Key('folder_screen'),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('${getFolderTitle()} List'),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget._folder.getImagePath()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(_addTodoAction.icon),
                onPressed: () {
                  _selectAppBarAction(_addTodoAction, context);
                },
              ),
              IconButton(
                icon: Icon(_editFolderAction.icon),
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index >= _todos.length) {
                  return null;
                }
                return GestureDetector(
                  child: new TodoItem(_todos[index], _handleTodoItemButtons),
                );
              },
            ),
          )
          // TodoList(widget._folder.getAllTodos(), Alignment.topCenter)
        ],
      ),
    );
  }

  String getFolderTitle() {
    return widget._folder.getTitle();
  }
}
