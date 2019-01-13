import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../classes/todo.dart';
import '../../../classes/enums.dart';

class TodoItem extends StatefulWidget {
  final Todo _todo;
  final Function _handleTodoItemButtons;

  TodoItem(this._todo, this._handleTodoItemButtons);

  @override
  State<StatefulWidget> createState() {
    return _TodoItemState();
  }
}

class _TodoItemState extends State<TodoItem> {
  void _showDatePickerDialog(BuildContext context) async {
    final DateTime selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(
        Duration(days: DateTime.now().day),
      ),
      lastDate: DateTime.now().add(
        Duration(days: 31),
      ),
      initialDate: widget._todo.getCompletionTime(),
    );
    setState(() {
      if (selectedDate != null) {
        widget._todo.setCompletionTime(selectedDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = new DateFormat.yMMMMd('en_US');
    print(widget._todo.getStatus());
    return Dismissible(
      key: PageStorageKey<Todo>(widget._todo),
      onDismissed: (direction) {
        widget._handleTodoItemButtons(widget._todo, TodoActions.Delete);
      },
      background: Container(
        color: Colors.red,
      ),
      child: ExpansionTile(
        key: PageStorageKey<Todo>(widget._todo),
        title: Text(widget._todo.getTitle(), style: TextStyle(fontSize: 20)),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Row(
              children: <Widget>[
                Text('Complete by '),
                Text(formatter.format(widget._todo.getCompletionTime())),
              ],
            ),
            onTap: () {
              _showDatePickerDialog(context);
            },
          ),
          ListTile(
            title: Text(
              widget._todo.getAdditionalNotes(),
            ),
            leading: Icon(Icons.edit),
            onTap: () {},
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                widget._todo.getStatus() == TodoStatus.Uncomplete
                    ? FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.check,
                              color: Colors.blue,
                            ),
                            Text(
                              'Mark as completed',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        onPressed: () {
                          widget._handleTodoItemButtons(
                              widget._todo, TodoActions.MarkCompleted);
                        },
                      )
                    : Container(),
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      Text(
                        'Remove',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  onPressed: () {
                    widget._handleTodoItemButtons(
                        widget._todo, TodoActions.Delete);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
