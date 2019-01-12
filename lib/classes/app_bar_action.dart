import 'package:flutter/material.dart';

enum Action {
  Add,
  Edit
}

class AppBarAction {
  const AppBarAction({this.title, this.icon, this.action});

  final String title;
  final IconData icon;
  final Action action;
}