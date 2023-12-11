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
          double screenWidth = MediaQuery.of(context).size.width;
          final userData = Provider.of<UserData>(context, listen: false);

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<UserData>(
                          builder: (context, userData, child) {
                            return userData.avatarUrl != null
                                ? Container(
                              width: screenWidth * 0.4,
                              height: screenWidth * 0.4,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 2.0,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  userData.avatarUrl!,
                                  width: screenWidth * 0.4,
                                  height: screenWidth * 0.4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                                : Container();
                          },
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<UserData>(
                                builder: (context, userData, child) {
                                  return Text(
                                    userData.name ?? '',
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.w800
                                    ),
                                  );
                                },
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/git_icon.png',
                                    width: screenWidth * 0.035,
                                    height: screenWidth * 0.035,
                                  ),
                                  SizedBox(width: screenWidth * 0.012,),
                                  Consumer<UserData>(
                                    builder: (context, userData, child) {
                                      return Text(
                                        userData.nickname ?? '',
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            fontWeight: FontWeight.w500
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  // 수정 버튼 눌렸을 때의 동작
                                },
                                child: Text(
                                  '내 정보 수정하기',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: Colors.white,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF939393),
                                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(userData.introduce ?? ''),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.link),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: userData.externalLink?.entries.map((entry) {
                              return Text('${entry.key}: ${entry.value}');
                            }).toList() ?? [],
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.language),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: userData.skill?.entries.expand((entry) {
                              return [
                                Text(entry.key),
                                Text(entry.value),
                                SizedBox(height: 8),
                              ];
                            }).toList() ?? [],
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.cake_outlined),
                          title: Text(userData.birthDate ?? ''),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.email_outlined),
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
                          leading: Icon(Icons.cake_outlined),
                          title: Text(userData.birthDate ?? ''),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
