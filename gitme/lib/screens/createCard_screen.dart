import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'templateColor_screen.dart';

class CreateCardScreen extends StatefulWidget {
  static const route = 'createCard-screen';

  const CreateCardScreen({Key? key}) : super(key: key);

  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  List<String> cardTemplate = [
    'assets/template4.jpg',
    'assets/template2.jpg',
    'assets/template3.jpg',
    'assets/template1.jpg',
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
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              children: List.generate(cardTemplate.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TemplateColorScreen(selectedTemplate: index.toString()),
                      ),
                    );
                  },
                  child: Card(
                    child: Image.asset(
                      cardTemplate[index],
                      width: 100, // 이미지 너비
                      height: 100, // 이미지 높이
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

}