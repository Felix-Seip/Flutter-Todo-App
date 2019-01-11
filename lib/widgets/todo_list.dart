import 'package:flutter/material.dart';
import '../classes/todo.dart';
import '../widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> _todos;
  final Alignment _alignment;

  const TodoList(this._todos, this._alignment);
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: _alignment,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
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
            },
          ),
        ),
      ),
    );
  }
}
