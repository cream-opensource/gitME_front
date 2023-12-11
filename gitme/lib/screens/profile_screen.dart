import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gitme/provider/userData.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'main_screen.dart';

final storage = FlutterSecureStorage();

class ProfileScreen extends StatefulWidget {
  static const route = 'profile-screen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        leading: IconButton(
          icon: Image.asset(
            'assets/back_button.png',
            width: 20,
            height: 20,
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Consumer<UserData>(
                            builder: (context, userData, child) {
                              return userData.avatarUrl != null
                                  ? ClipOval(
                                child: Image.network(
                                  userData.avatarUrl!,
                                  fit: BoxFit.cover,
                                  width: constraints.maxWidth * 0.35,
                                  height: constraints.maxWidth * 0.35,
                                ),
                              )
                                  : Container();
                            },
                          ),
                          SizedBox(width: screenWidth * 0.02),
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
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              '수정',
                              style: TextStyle(
                                color: Color(0xFF676A66),
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenWidth * 0.1),
                SizedBox(
                  width: constraints.maxWidth * 0.9,
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.person_outline),
                          title: Text('Hoon'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.email),
                          title: Text('your@email.com'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('000-0000-0000'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.favorite),
                          title: Text('1998.12.11'),
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
          );
        },
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
