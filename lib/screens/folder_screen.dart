import 'package:flutter/material.dart';

import '../widgets/todo_list.dart';

import '../classes/app_bar_action.dart';
import '../classes/folder.dart';

class FolderScreen extends StatelessWidget {
  final Folder _folder;

  FolderScreen(this._folder);

  final List<AppBarAction> choices = const <AppBarAction>[
    const AppBarAction(title: 'Edit', icon: Icons.edit),
    const AppBarAction(title: 'Delete', icon: Icons.delete),
  ];

  AppBarAction _selectedAction;

  void _select(AppBarAction action) {
    if (action.title == '') {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${getFolderTitle()} List'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              maxHeight: 250.0,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_folder.getImagePath()),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: PopupMenuButton<AppBarAction>(
                onSelected: _select,
                itemBuilder: (BuildContext context) {
                  return choices.map((AppBarAction choice) {
                    return PopupMenuItem<AppBarAction>(
                      value: choice,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Icon(
                              choice.icon,
                            ),
                          ),
                          Text(choice.title)
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ),
          TodoList(_folder.getAllTodos(), Alignment.topCenter)
        ],
      ),
    );
  }

  String getFolderTitle() {
    return _folder.getTitle();
  }
}
