import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gitme/provider/userData.dart';
import 'package:gitme/widgets/add_card.dart';
import 'package:gitme/widgets/card1.dart';
import 'package:gitme/widgets/card2.dart';
import 'package:gitme/widgets/card3.dart';
import 'package:gitme/widgets/card4.dart';
import 'package:gitme/widgets/custom_drawer_btn.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../service/business_card_data.dart';

class MainScreen extends StatefulWidget {
  static const route = 'main-screen';
  final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<bool> isFlippedList = [false]; // 초기에 앞면(false)으로 시작
  int _current = 0; // 현재 명함 인덱스를 알려주는 변수
  late UserData userData; // UserData 타입의 변수를 선언
  String userName = ""; // nullable로 변경

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    userData = UserData();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      userData = Provider.of<UserData>(context, listen: false);
      print('성공');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('error: $e');
      // } finally {
      //   setState(() {
      //     isLoading = false;
      //   });
    }
  }

  Future<void> captureAndSave() async {
    try {
      RenderRepaintBoundary boundary = widget.globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0); // 예시에서는 3.0 사용

      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // 이미지를 갤러리에 저장합니다.
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(pngBytes),
        quality: 90, // 이미지 품질 설정 (0에서 100까지, 기본값은 80)
      );
      if (result != null && result.isNotEmpty) {
        print('이미지 저장 성공');
      } else {
        print('이미지 저장 실패');
      }
    } catch (e) {
      print('에러: $e');
    }
  }

  Future<String> createDynamicLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://gitme.page.link',
      link: Uri.parse(
          'https://gitme.com/card?userIdx=${userData.userIdx}&templateIdx=$_current'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.gitme',
        fallbackUrl: Uri.parse('https://naver.com'),
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.example.gitme',
        minimumVersion: '12.0',
        fallbackUrl: Uri.parse('https://naver.com'),
      ),
    );

    ShortDynamicLink dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return dynamicLink.shortUrl.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    }
    List<Widget> items = List.generate( 4, (index) {
        return FlipCard(
            front: getBusinessCardWidget(index + 1, userData),
            back: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 400,
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: Color(0xFFCEF700),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: QrImageView(
                      data: "hi im qrcode : $_current",
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16), // 텍스트와 QR 코드 사이 간격 조절
                  Text(
                    'Scan Me!',
                    style: TextStyle(
                      color: Color(0xFF393737),
                      fontSize: 24,
                      //fontFamily: 'AbhayaLibre-ExtraBold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        );
      },
        // AddCard());
    );

    return Scaffold(
      appBar: null,
      body: RepaintBoundary(
        key: widget.globalKey,
        child: Stack(
          children: <Widget>[
            CustomDrawerBtn(),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left: 16,
              right: 16,
              child: CarouselSlider(
                items: items,
                options: CarouselOptions(
                  height: 520.0,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.15,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  items.length,
                  (index) => Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _current == index ? Color(0xFF56CC94) : Colors.grey,
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
      ),
      drawer: MainDrawer(),
    );
  }

  Widget getBusinessCardWidget(int cardIndex, UserData userData) {
    final businessCardData = BusinessCardData(
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
    );

    switch (cardIndex) {
      case 1:
        return BusinessCard1(businessCardData);
      case 2:
        return BusinessCard2(businessCardData);
      case 3:
        return BusinessCard3(businessCardData);
      case 4:
        return BusinessCard4(businessCardData);
      default:
        throw Exception("Invalid card index");
    }
  }

  void showShareOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () {
                captureAndSave();
              },
              child: Text('이미지로 저장하기'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                String dynamicLink = await createDynamicLink();
                print('공유 링크: $dynamicLink');
                Navigator.of(dialogContext).pop();
              },
              child: Text('공유하기'),
            ),
          ],
        );
      },
    );
  }
}
