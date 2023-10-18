import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Icon(Icons.star),
            Icon(Icons.star),
            Icon(Icons.star)

          ]
        ),
      ),
    );
  }
}