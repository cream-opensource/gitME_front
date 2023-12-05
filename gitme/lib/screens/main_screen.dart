import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gitme/provider/userData.dart';
import 'package:gitme/screens/dynamic_link_screen.dart';
import 'package:gitme/widgets/card.dart';
import 'package:gitme/widgets/card2.dart';
import 'package:gitme/widgets/card3.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:gitme/widgets/custom_drawer_btn.dart';
import 'package:gitme/widgets/qrcode.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import '../service/apiService.dart';

class MainScreen extends StatefulWidget {
  static final route = 'main-screen';
  final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

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
    } catch (e) {
      print('error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> captureAndSave() async {
    try {
      RenderRepaintBoundary boundary = widget.globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // 이미지를 갤러리에 저장합니다.
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes));

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
      uriPrefix: 'https://gitME.page.link',
      link: Uri.parse('https://gitME.page.link/card?id=$_current'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.gitme',
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.example.gitme',
        minimumVersion: '12.0',
      ),
    );

    ShortDynamicLink dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return dynamicLink.shortUrl.toString();
  }

  Future<void> handleDynamicLink() async {
    try {
      // Get the dynamic link
      final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();

      // Extract card ID from the dynamic link data
      String cardIdFromDynamicLink = extractCardIdFromLinkData(data);

      // Check if card ID is valid
      if (cardIdFromDynamicLink.isNotEmpty) {
        // Navigate to the screen with the extracted card ID
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DynamicLinkScreen(cardId: cardIdFromDynamicLink),
          ),
        );
      }
    } catch (e) {
      print('Error handling dynamic link: $e');
    }
  }



  String extractCardIdFromLinkData(PendingDynamicLinkData? data) {
    // Add your logic to extract the card ID based on the dynamic link data structure
    // For example, if the link is 'https://gitME.page.link/card?id=123', you can extract '123'
    if (data != null && data.link != null) {
      Uri link = data.link!;
      List<String> pathSegments = link.pathSegments;
      if (pathSegments.isNotEmpty && pathSegments.first == 'card') {
        return pathSegments.length > 1 ? pathSegments[1] : '';
      }
    }
    return '';
  }

  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    }
    List<Widget> items = [
      FlipCard(
          front: BusinessCard3(
            BusinessCardData3(
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
        back: Container(
          // 카드 크기와 일치하는 컨테이너 생성
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
          padding: EdgeInsets.all(16.0), // 원하는 패딩값 설정
          child: Center(
            child: QrImageView(
              data: "hi im qrcode : ${_current}",
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
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
          back: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QrImageView(
                  data: "hi im qrcode : ${_current}",
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ],
            ),
          ),
      ),
    ];
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
                  height: 500.0,
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
              bottom: MediaQuery.of(context).size.height * 0.2,
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
                captureAndSave();
              },
              child: Text('이미지로 저장하기'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                String dynamicLink = await createDynamicLink();
                print('공유 링크: $dynamicLink');

                await handleDynamicLink();
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
