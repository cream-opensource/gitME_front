import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:gitme/widgets/card.dart';
import 'package:gitme/widgets/card2.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:gitme/widgets/custom_drawer_btn.dart';
import 'package:gitme/widgets/qrcode.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MainScreen extends StatefulWidget {
  static final route = 'main-screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<bool> isFlippedList = [false]; // 초기에 앞면(false)으로 시작

  @override
  Widget build(BuildContext context) {
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
              items: [
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
                      data: "hi im qrcode",
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
                      data: "hi im qrcode",
                      version: QrVersions.auto,
                      size: 200.0,
                    )),
                FlipCard(
                    front: BusinessCard2(
                      BusinessCardData2(
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
                      data: "hi im qrcode",
                      version: QrVersions.auto,
                      size: 200.0,
                    )),
              ],
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
