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
            top: MediaQuery.of(context).size.height * 0.1, // 화면 높이의 10% 지점
            left: 16,
            right: 16,
            child: Column(
              children: <Widget>[
                BusinessCard(
                  BusinessCardData(
                      name: "최훈",
                      jobTitle: "Frontend Developer",
                      contactInfo: "kc0393@gmail.com",
                      call: "010-3089-1093",
                      techStack: "React",
                      introduce: "안녕하세요 프론트엔드 개발자 최훈 입니다."),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 버튼 간 간격 설정
              children: [
                ElevatedButton(
                  onPressed: () {

                  },
                  child: Text("QR코드"),
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: Text("Img저장"),
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: Text("kakao공유"),
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
