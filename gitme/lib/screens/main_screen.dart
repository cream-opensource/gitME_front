import 'package:gitme/widgets/custom_drawer_btn.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import '../widgets/card.dart';

class VerticalBusinessCard extends StatelessWidget {
  final BusinessCardData data;

  VerticalBusinessCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // 세로 비즈니스 카드의 너비 설정
      height: 500, // 세로 비즈니스 카드의 높이 설정
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 30), // 비즈니스 카드를 아래로 내리기 위한 여백 설정
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            data.jobTitle,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "기술 스택: ${data.techStack}",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "Followers: ${data.followers}",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "Stared: ${data.stared}",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "Commit: ${data.commit}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            "소개글: ${data.introduce}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            "전화번호: ${data.call}",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

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
                VerticalBusinessCard(
                  BusinessCardData(
                      name: "최훈",
                      jobTitle: "Frontend Developer",
                      contactInfo: "kc0393@gmail.com",
                      call: "010-3089-1093",
                      techStack: "React",
                      followers: "1000", // 팔로워 수 추가
                      stared: "500", // 스타 수 추가
                      commit: "1000", // 커밋 수 추가
                      introduce: "안녕하세요 프론트엔드 개발자 최훈 입니다."),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
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
