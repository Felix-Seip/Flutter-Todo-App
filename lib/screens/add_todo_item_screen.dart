import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../classes/todo.dart';

class AddTodoItemScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddTodoItemScreenState();
  }
}

class _AddTodoItemScreenState extends State<AddTodoItemScreen> {
  String _title;
  DateTime _completionDate;
  String _additionalNotes;
  DateFormat formatter = new DateFormat.yMMMMd('en_US');

  void _showDatePickerDialog(BuildContext context) async {
    final DateTime selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(
        Duration(days: DateTime.now().day),
      ),
      lastDate: DateTime.now().add(
        Duration(days: 31),
      ),
      initialDate: DateTime.now(),
    );
    setState(() {
      if (selectedDate != null) {
        _completionDate = selectedDate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add To-Do Item'),
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
              Navigator.pop(
                  context, Todo(_title, _completionDate, _additionalNotes));
            },
          )
        ],
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 10.0,
        crossAxisCount: 1,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "To-Do Item Title",
                    ),
                    onChanged: (text) {
                      setState(
                        () {
                          _title = text;
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                  child: FocusScope(
                    node: FocusScopeNode(),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "Completion Date",
                      ),
                      controller: TextEditingController(
                        text: _completionDate == null ? '' : formatter.format(_completionDate),
                      ),
                      autofocus: false,
                      onTap: () {
                        _showDatePickerDialog(context);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Additional Notes",
                    ),
                    onChanged: (text) {
                      setState(
                        () {
                          _additionalNotes = text;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
