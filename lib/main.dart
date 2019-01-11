import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromARGB(255, 34, 116, 165)),
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
