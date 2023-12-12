import 'package:flutter/material.dart';
import 'package:gitme/provider/userData.dart';
import 'package:gitme/widgets/card1.dart';
import 'package:gitme/widgets/card2.dart';
import 'package:gitme/widgets/card3.dart';
import 'package:gitme/widgets/card4.dart';

class TemplateColorScreen extends StatefulWidget {
  static const route = 'templateColor-screen';
  final String selectedTemplate;

  const TemplateColorScreen({Key? key, required this.selectedTemplate}) : super(key: key);

  @override
  _TemplateColorScreenState createState() => _TemplateColorScreenState();
}

class _TemplateColorScreenState extends State<TemplateColorScreen> {

  late UserData userData;

  @override
  void initState() {
    super.initState();
    userData = UserData(); // 적절한 초기화 방법에 따라 변경해야 합니다.
  }

  Widget _buildCardWidget() {
    switch (widget.selectedTemplate) {
      case '0':
        return Card(
          child: BusinessCard4(
            BusinessCardData4(
              name: userData.name ?? "",
              jobTitle: "Frontend Developer",
              contactInfo: userData.email ?? "",
              call: userData.phone ?? "",
              techStack: userData.languages?['JavaScript'].toString() ?? "",
              followers: userData.followers.toString(),
              stared: userData.totalStars.toString(),
              commit: userData.totalCommits.toString(),
              introduce: userData.nickname ?? "",
            ),
          ),
        );
      case '1':
        return Card(
          child: BusinessCard2(
            BusinessCardData2(
              name: userData.name ?? "",
              jobTitle: "Frontend Developer",
              contactInfo: userData.email ?? "",
              call: userData.phone ?? "",
              techStack: userData.languages?['JavaScript'].toString() ?? "",
              followers: userData.followers.toString(),
              stared: userData.totalStars.toString(),
              commit: userData.totalCommits.toString(),
              introduce: userData.nickname ?? "",
            ),
          ),
        );
      case '2':
        return Card(
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
        );
      case '3':
        return Card(
          child: BusinessCard1(
            BusinessCardData1(
              name: userData.name ?? "",
              jobTitle: "Frontend Developer",
              contactInfo: userData.email ?? "",
              call: userData.phone ?? "",
              techStack: userData.languages?['JavaScript'].toString() ?? "",
              followers: userData.followers.toString(),
              stared: userData.totalStars.toString(),
              commit: userData.totalCommits.toString(),
              introduce: userData.nickname ?? "",
            ),
          ),
        );
      default:
        return Center(
          child: Text(
            '템플릿을 찾을 수 없습니다!',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
            Navigator.pop(context);
          },
        ),
        title: Text(
          '배경 색 선택',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            height: screenWidth * 1.3,
            child: _buildCardWidget(),
          ),
          SizedBox(height: screenWidth * 0.03),
          ElevatedButton(
            onPressed: () {

            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF56CC94)), // 버튼 배경색 설정
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            child: Container(
              width: 80,
              child: Center(
                child: Text('추가', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}