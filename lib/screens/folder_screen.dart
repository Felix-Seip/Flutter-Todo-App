import 'package:flutter/material.dart';

import '../widgets/todo_item.dart';

import '../screens/add_todo_item_screen.dart';

import '../classes/app_bar_action.dart';
import '../classes/folder.dart';
import '../classes/todo.dart';

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
        MaterialPageRoute(builder: (context) => AddTodoItemScreen()),
      );
      if (todo != null) {
        setState(() {
          widget._folder.addTodo(todo);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> _todos = widget._folder.getAllTodos();

    return Scaffold(
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
                if(index >= _todos.length){
                  return null;
                }
                return GestureDetector(
                  child: new TodoItem(_todos[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  String getFolderTitle() {
    return widget._folder.getTitle();
  }
}
