import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/main.dart';
import '../screens/manu.dart';
import '../screens/privacy.dart';

class MenuBottom extends StatefulWidget {
  @override
  _MenuBottomState createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuBottom> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MainScreen(),
    ManuScreen(),
    PrivacyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Main'),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: 'Manufacture'),
          BottomNavigationBarItem(icon: Icon(Icons.people_alt), label: 'Privacy'),
        ],
      ),
    );
  }
}
