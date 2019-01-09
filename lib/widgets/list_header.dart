import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  final String _title;
  final EdgeInsets _edgeInsets;

  const ListHeader(this._title, this._edgeInsets);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: _edgeInsets,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(_title, style: TextStyle(fontSize: 22))));
  }
}
