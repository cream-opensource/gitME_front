import 'package:flutter/material.dart';
import 'package:gitme/screens/flutter_screen.dart';
import 'package:gitme/screens/login_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/screens/profile_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                child: Image.asset(
                  'assets/profile_bg_01.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                width: 100,
                height: 100,
                child: Image.asset('assets/default-user.png'),
              )
            ],
          ),
          SizedBox(height: 30),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              MainScreen.route,
            ),
            leading: Icon(Icons.account_circle),
            title: Text(
              'home',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              LoginScreen.route,
            ),
            leading: Icon(Icons.account_circle),
            title: Text(
              '로그인',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              ProfileScreen.route,
            ),
            leading: Icon(Icons.account_circle),
            title: Text(
              '명함지갑',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              FlutterScreen.route,
            ),
            leading: Icon(Icons.account_circle),
            title: Text(
              '명함목록',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}