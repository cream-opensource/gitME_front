import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gitme/provider/userData.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/widgets/card1.dart';
import 'package:gitme/widgets/card2.dart';
import 'package:gitme/widgets/card3.dart';
import 'package:gitme/widgets/card4.dart';
import 'package:gitme/service/business_card_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TemplateColorScreen extends StatefulWidget {
  static const route = 'templateColor-screen';
  final String selectedTemplate;

  TemplateColorScreen({super.key, required this.selectedTemplate});

  @override
  _TemplateColorScreenState createState() => _TemplateColorScreenState();
}

class _TemplateColorScreenState extends State<TemplateColorScreen> {
  late BusinessCardData businessCardData;
  late UserData userData; // UserData 타입의 변수를 선언
  Color pickerColor = Color(0xFF000000); // 선택한 색상을 저장할 변수

  void changeColor(Color color) {
    setState(() => pickerColor = color); // 선택한 색상을 업데이트
  }

  void showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('색상 선택'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              // 색상이 변경될 때마다 호출될 함수
              colorPickerWidth: 300.0,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(2.0),
                topRight: const Radius.circular(2.0),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                //addCardToServer(int.parse(widget.selectedTemplate) + 1, pickerColor.toString(), 2);
                Navigator.pop(context); // 이전 화면으로 돌아가기
              },
              child: Container(
                width: 80,
                child: Center(
                  child: Text(
                    '완료',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchDataFromServer() async {
    try {
      userData = Provider.of<UserData>(context, listen: false);
      print('성공');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> addCardToServer(
      int templateIdx, String color, int sequence) async {
    final Map<String, dynamic> cardData = {
      'userIdx': userData.userIdx,
      'templateIdx': templateIdx,
      'color': color,
      'sequence': sequence,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/card'),
        body: json.encode(cardData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        print('Card added successfully');
      } else {
        print('Failed to add card: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding card: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    userData = UserData();
    fetchDataFromServer();
    businessCardData = BusinessCardData(
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
  }

  Widget _buildCardWidget() {
    switch (widget.selectedTemplate) {
      case '0':
        return Card(
            child: BusinessCard1(businessCardData, primaryColor: pickerColor));
      case '1':
        return Card(
            child:
                BusinessCard2(businessCardData, primaryColor: pickerColor) // 여기서도 비슷한 방식으로 색상을 전달할 수 있습니다.
            );
      case '2':
        return Card(
            child:
                BusinessCard3(businessCardData, primaryColor: pickerColor) // 여기서도 비슷한 방식으로 색상을 전달할 수 있습니다.
            );
      case '3':
        return Card(
            child:
                BusinessCard4(businessCardData, primaryColor: pickerColor) // 여기서도 비슷한 방식으로 색상을 전달할 수 있습니다.
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
          Row(
            // Row 추가
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 버튼들을 균등하게 정렬
            children: [
              ElevatedButton(
                onPressed: () {
                  print(int.parse(widget.selectedTemplate));
                  addCardToServer(int.parse(widget.selectedTemplate) + 1,
                      pickerColor.toString(), 2);
                  Navigator.pushNamed(context, MainScreen.route);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFF56CC94)), // 버튼 배경색 설정
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Container(
                  width: 80,
                  child: Center(
                    child: Text('추가',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: showColorPicker,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFF56CC94)), // 버튼 배경색 설정
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Container(
                  width: 80,
                  child: Center(
                    child: Text('색상 선택',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
