import 'package:flutter/material.dart';
import 'package:gitme/widgets/card2.dart';
import 'package:provider/provider.dart';

import '../provider/userData.dart';
import '../widgets/card3.dart';
import 'main_screen.dart';

class ShareScreen extends StatefulWidget {
  static const route = 'share-screen';

  final String userIdx;
  final String cardIdx;

  ShareScreen({required this.userIdx, required this.cardIdx});

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<ShareScreen> {
  late UserData userData;

  @override
  void initState() {
    super.initState();
    userData = Provider.of<UserData>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userDataMap = userData.getUserData();
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: BusinessCard3(
                  BusinessCardData3(
                    name: userData.name ?? "",
                    birthdate: userData.birthDate ?? "",
                    email: userData.email ?? "",
                    phone: userData.phone ?? "",
                    introduce: userData.introduce ?? "",
                    externalLink: userData.externalLink,
                    nickname: userData.nickname ?? "",
                    followers: userData.followers?.toString() ?? "",
                    following: userData.following?.toString() ?? "",
                    totalStars: userData.totalStars?.toString() ?? "",
                    totalCommits: userData.totalCommits?.toString() ?? "",
                    avatarUrl: userData.avatarUrl ?? "",
                    languages: userData.languages,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('저장');
                        print(userDataMap);
                      },
                      child: Text('저장'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF56CC94),
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(MainScreen.route);
                      },
                      child: Text('나가기'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF56CC94),
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
