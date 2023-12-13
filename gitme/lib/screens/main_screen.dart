import 'dart:convert';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gitme/provider/userData.dart';
import 'package:gitme/widgets/card1.dart';
import 'package:gitme/widgets/card2.dart';
import 'package:gitme/widgets/card3.dart';
import 'package:gitme/widgets/card4.dart';
import 'package:gitme/widgets/custom_drawer_btn.dart';
import 'package:gitme/widgets/custom_loading_indicator.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;

import '../service/business_card_data.dart';
import '../widgets/add_card.dart';

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
  Map<int, String> _dynamicLinks = {};
  List<Widget> items = []; // items 선언

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    userData = UserData();
    fetchDataFromServer();
    _loadDynamicLink();
    addCardToServer(2, "Color(0xFF9BB7FF)", 1);
    updateCardsFromServer();

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

  void _loadDynamicLink() async {
    String link = await createDynamicLink();
    setState(() {
      _dynamicLinks[_current] = link;
    });
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

  Future<void> addCardToServer(int templateIdx, String color, int sequence) async {
    final Map<String, dynamic> cardData = {
      'userIdx': userData.userIdx,
      'templateIdx': templateIdx,
      'color': color,
      'sequence': sequence,
    };

    try {
      final response = await http.post(
        Uri.parse('https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/card'),
        body: json.encode(cardData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        print('Card added successfully');
        updateCardsFromServer();
      } else {
        print('Failed to add card: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding card: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchCardDataList() async {
    await Future.delayed(Duration(seconds: 1));

    final response = await http.get(Uri.parse('https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/card/${userData.userIdx}'));
    if (response.statusCode == 201) {
      final List<dynamic> data = json.decode(response.body);
      return data.map<Map<String, dynamic>>((cardInfo) {
        String colorString = cardInfo['color'];

        // 'Color(0xff000000)' 형태의 문자열에서 '0xff000000' 부분만 추출합니다.
        colorString = colorString.split('(')[1].split(')')[0];

        // '0xff000000'에서 '0xff'를 제거하고, 남은 부분을 16진수 정수로 변환합니다.
        int colorValue = int.parse(colorString.substring(2, 10), radix: 16) + 0xFF000000;

        cardInfo['color'] = Color(colorValue);
        return cardInfo;
      }).toList();
    } else {
      throw Exception('Failed to load card data');
    }
  }



  Future<void> updateCardsFromServer() async {
    setState(() {
      isLoading = true;
    });

    try {
      final cardInfoList = await fetchCardDataList();

      items = List.generate(cardInfoList.length, (index) {
        final cardInfo = cardInfoList[index];
        final cardIndex = cardInfo['templateIdx'];
        final Color cardColor = cardInfo['color'];

        return FlipCard(
          front: getBusinessCardWidget(cardIndex, userData, cardColor),
          back: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 400,
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              color: Color(0xFF56CC94),
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
                Container(
                  width: 220, // 컨테이너의 너비
                  height: 220, // 컨테이너의 높이
                  decoration: BoxDecoration(
                    color: Colors.white, // 흰 배경
                    borderRadius: BorderRadius.circular(20.0), // 모서리를 둥글게 함
                    border: Border.all(color: Colors.white, width: 5.0), // 이미지 주위에 흰 테두리 추가
                  ),
                  child: Center(
                    child: QrImageView(
                      data: _dynamicLinks[cardIndex] ?? "",
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.transparent, // 배경이 흰색으로 처리되므로 투명으로 설정
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Scan Me!',
                  style: TextStyle(
                    color: Color(0xFF393737),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      });
      items.add(AddCard());

      // 화면 갱신 완료
    } catch (e) {
      print('에러: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CustomLoadingIndicator();
    }
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
                      if (!_dynamicLinks.containsKey(index)) {
                        _loadDynamicLink();
                      }
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

  Widget getBusinessCardWidget(int cardIndex, UserData userData, Color color) {
    final businessCardData = BusinessCardData(
      name: userData.name ?? "",
      birthdate: userData.birthDate ?? "",
      email: userData.email ?? "",
      phone: userData.phone ?? "",
      introduction: userData.introduction ?? "",
      externalLink: userData.externalLink,
      nickname: userData.nickname ?? "",
      followers: userData.followers?.toString() ?? "",
      following: userData.following?.toString() ?? "",
      totalStars: userData.totalStars?.toString() ?? "",
      totalCommits: userData.totalCommits?.toString() ?? "",
      avatarUrl: userData.avatarUrl ?? "",
      languages: userData.languages,
      skillProficiency: userData.skillProficiency ?? "",
    );

    switch (cardIndex) {
      case 1:
        return BusinessCard1(businessCardData, primaryColor: color);
      case 2:
        return BusinessCard2(businessCardData, primaryColor: color);
      case 3:
        return BusinessCard3(businessCardData, primaryColor: color);
      case 4:
        return BusinessCard4(businessCardData, primaryColor: color);
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

                // 클립보드에 동적 링크 복사
                Clipboard.setData(ClipboardData(text: dynamicLink)).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('링크가 클립보드에 복사되었습니다.'))
                  );
                });

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
