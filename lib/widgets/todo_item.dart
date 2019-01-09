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
        Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0, 0, 10.0),
                    child: Text(
                      'Title',
                      style: TextStyle(fontSize: 16),
                    )),
                Container(
                    child: TextField(
                  controller: TextEditingController(text: _todo.getTitle()),
                ))
              ],
            ))
      ],
    );
  }
}
