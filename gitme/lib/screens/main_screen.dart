import 'package:gitme/widgets/card2.dart';
import 'package:gitme/widgets/custom_drawer_btn.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import '../widgets/card.dart';

class MainScreen extends StatelessWidget {
  static final route = 'main-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: <Widget>[
          CustomDrawerBtn(),
          SizedBox(height: 30.0),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15, // 화면 높이의 10% 지점
            left: 16,
            right: 16,
            child: Column(
              children: <Widget>[
                BusinessCard2(
                  BusinessCardData2(
                      name: "조재중",
                      jobTitle: "Frontend Developer",
                      contactInfo: "kc0393@gmail.com",
                      call: "010-1234-5678",
                      techStack: "React",
                      followers: "1000",
                      // 팔로워 수 추가
                      stared: "500",
                      // 스타 수 추가
                      commit: "1000",
                      // 커밋 수 추가
                      introduce: "m_a_king"),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),

    );
  }
}
