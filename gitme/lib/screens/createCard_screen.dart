import 'package:flutter/material.dart';
import 'main_screen.dart';

class CreateCardScreen extends StatefulWidget {
  static const route = 'createCard-screen';

  const CreateCardScreen({Key? key}) : super(key: key);

  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  List<String> cardTemplate = [
    'assets/card1.png',
    'assets/card2.png',
    'assets/card3.png',
    'assets/card4.png',
  ];

  @override
  Widget build(BuildContext context) {
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
            Navigator.of(context).pushNamed(MainScreen.route);
          },
        ),
        title: Text(
          '명함 만들기',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 수직 및 수평 여백 추가
              child: Text(
                '원하는 명함의 디자인을 선택해 주세요!',
                style: TextStyle(
                  color: Color(0xFF676A66),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 한 줄에 보여질 아이템 수
                childAspectRatio: 0.7, // 이미지에 맞는 비율 조정
                children: List.generate(cardTemplate.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      // 선택한 템플릿을 MainScreen으로 전달
                      Navigator.of(context).pop(cardTemplate[index]);
                    },
                    child: Card(
                      child: Image.asset(cardTemplate[index]),
                    ),
                  );
                }),
              ),
            ),
          ]
      ),
    );
  }
}
