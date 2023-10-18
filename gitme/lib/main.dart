import 'package:flutter/material.dart';
import 'package:gitme/shared/menu_bottom.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gitME',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuBottom(),
    );
  }
}