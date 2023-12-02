import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:gitme/provider/userData.dart';
import 'package:gitme/widgets/card.dart';
import 'package:gitme/widgets/card2.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:gitme/widgets/custom_drawer_btn.dart';
import 'package:gitme/widgets/qrcode.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../service/apiService.dart';

class MainScreen extends StatefulWidget {
  static final route = 'main-screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<bool> isFlippedList = [false]; // 초기에 앞면(false)으로 시작
  int _current = 0; // 현재 명함 인덱스를 알려주는 변수
  late UserData userData; // UserData 타입의 변수를 선언
  String userName = ""; // nullable로 변경

  final ServerCommunication serverCommunication = ServerCommunication();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      await serverCommunication.fetchDataFromServer(context);
      userData = Provider.of<UserData>(context, listen: false);
      print('성공');
    } catch (e) {
      print('error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    }
    List<Widget> items = [
      FlipCard(
          front: BusinessCard(
            BusinessCardData(
              name: userData.name ?? "",
              jobTitle: "Frontend Developer",
              contactInfo: userData.email ?? "",
              call: userData.phone ?? "",
              techStack: userData.languages?['JavaScript'].toString() ?? "",
              followers: userData.followers.toString() ?? "",
              stared: userData.totalStars.toString() ?? "",
              commit: userData.totalCommits.toString() ?? "",
              introduce: userData.nickname ?? "",
            ),
          ),
          back: QrImageView(
            data: "hi im qrcode : ${_current}",
            version: QrVersions.auto,
            size: 200.0,
          )),
      FlipCard(
          front: BusinessCard(
            BusinessCardData(
              name: "조재중",
              jobTitle: "Frontend Developer",
              contactInfo: "kc0393@gmail.com",
              call: "010-1234-5678",
              techStack: "React",
              followers: "1000",
              stared: "500",
              commit: "1000",
              introduce: "m_a_king",
            ),
          ),
          back: QrImageView(
            data: "hi im qrcode : ${_current}",
            version: QrVersions.auto,
            size: 200.0,
          )),
    ];
    return Scaffold(
      appBar: null,
      body: Stack(
        children: <Widget>[
          CustomDrawerBtn(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 16,
            right: 16,
            child: CarouselSlider(
              items: items,
              options: CarouselOptions(
                height: 500.0,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                initialPage: 0,
                // 초기 페이지 설정
                enableInfiniteScroll: false,
                // 무한 스크롤 사용 여부
                reverse: false,
                // 캐러셀 역방향 스크롤 여부
                autoPlay: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
          ),
          // Indicator 추가
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2, // 10%의 여백을 설정
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                // Indicator의 개수를 items의 개수로 설정
                items.length,
                    (index) => Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 45,
            right: 10,
            child: IconButton(
              icon: Image.asset(
                'assets/share.png',
                width: 24.0,
                height: 24.0,
              ),
              onPressed: () {
                print('Share button pressed');
                showShareOptionsDialog(context);
              },
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }

  void showShareOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // 닫기
              },
              child: Text('이미지로 저장하기'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('카카오톡으로 공유하기'),
            ),
          ],
        );
      },
    );
  }
}
