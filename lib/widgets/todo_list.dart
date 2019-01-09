import 'package:flutter/material.dart';
import '../classes/todo.dart';
import '../widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> _todos;
  final Alignment _alignment;

  const TodoList(this._todos, this._alignment);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: _alignment,
        child: Container(
            height: 250.0,
            margin: EdgeInsets.all(20.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _todos.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: new TodoItem(_todos[index]),
                    onTap: () {
                      print('tapped $index');
                    },
                  );
                })));
  }
}
