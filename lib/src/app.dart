import 'package:flutter/material.dart';
import 'package:to_do_app/screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
    );
  }
}
