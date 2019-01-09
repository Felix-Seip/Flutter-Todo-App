import 'package:flutter/material.dart';
import '../classes/folder.dart';
import '../widgets/todo_list.dart';

class FolderScreen extends StatelessWidget {
  final Folder _folder;

  const FolderScreen(this._folder);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${getFolderTitle()} List'),
        ),
        body: TodoList(_folder.getAllTodos(), Alignment.topCenter));
  }

  String getFolderTitle() {
    return _folder.getTitle();
  }
}
