import 'package:flutter/material.dart';

import '../classes/folder.dart';
import '../classes/todo.dart';

class AddFolderScreen extends StatelessWidget {
  String _folderTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add To-Do List'),
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, Folder(_folderTitle, <Todo>[], "assets/wallpaper.jpg"));
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: "To-Do list name",
              ),
              onChanged: (text) {
                _folderTitle = text;
              },
            )
          ],
        ),
      ),
    );
  }
}
