import 'package:flutter/material.dart';

import 'package:gitme/provider/pixabay_photos.dart';
import 'package:gitme/screens/flutter_screen.dart';
import 'package:gitme/screens/login_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/screens/profile_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Drawer without AppBar',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
        routes: {
          MainScreen.route: (_) => MainScreen(),
          FlutterScreen.route: (_) => FlutterScreen(),
          ProfileScreen.route: (_) => ProfileScreen()
        },
      );
  }
}