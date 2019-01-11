import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../classes/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo _todo;

  TodoItem(this._todo);

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
      widget._todo.setCompletionTime(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = new DateFormat.yMMMMd('en_US');
    return ExpansionTile(
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
        )
      ],
    );
  }
}
