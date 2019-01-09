import 'package:flutter/material.dart';
import '../classes/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(this._todo);

  final Todo _todo;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: PageStorageKey<Todo>(_todo),
      title: Text(_todo.getTitle(), style: TextStyle(fontSize: 20)),
      children: <Widget>[
        ListTile(title: Text('ABC'),)
      ],
    );
  }
}
