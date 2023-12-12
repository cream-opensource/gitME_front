import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../provider/userData.dart';
import 'main_screen.dart';

final storage = FlutterSecureStorage();

class ProfileScreen extends StatefulWidget {
  static const route = 'profile-screen';

  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        leading: IconButton(
          icon: Image.asset(
            'assets/back_button.png', // 이미지 경로
            width: 20, // 이미지 너비
            height: 20, // 이미지 높이
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(MainScreen.route);
          },
        ),
        title: Text(
          '마이페이지',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'jjj.png', // 이미지 경로
                      width: 50, // 이미지 너비
                      height: 50, // 이미지 높이
                    ),
                    SizedBox(width: 5), // 이미지와 텍스트 사이 간격 조정
                    Text(
                      '조재중',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFF676A66),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {

                  },
                  child: Row(
                    children: [
                      Text(
                        '수정',
                        style: TextStyle(
                          color: Color(0xFF676A66),
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.0),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text(userData.name ?? ''),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text(userData.email ?? ''),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(userData.phone ?? ''),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text(userData.birthDate ?? ''),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: _logout,
                    leading: Icon(Icons.logout),
                    title: Text('로그아웃'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),

    );
  }

  Future<void> _logout() async {
    await storage.delete(key: 'login_token');
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => MyApp(),
    ));
  }
}