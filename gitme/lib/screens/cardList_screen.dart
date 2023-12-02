import 'package:flutter/material.dart';
import 'main_screen.dart';

class CardListScreen extends StatelessWidget {
  static final route = 'cardList-screen';

  List<String> cardImages = [
    'assets/card1.png',
    'assets/card2.png',
    'assets/card3.png',
    'assets/card4.png',
    'assets/card5.png',
    'assets/card6.png',
    'assets/card1.png',
    'assets/card2.png',
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
          '내 명함',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 16),
              Image.asset(
                'assets/cardlist.png', // 이미지 경로
                width: 50, // 이미지 너비
                height: 50, // 이미지 높이
              ),
              SizedBox(width: 5), // 이미지와 텍스트 사이 간격 조정
              Text(
                '${cardImages.length}개 보관중',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFF676A66),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: cardImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(cardImages[index]),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // #TODO:  index에 맞는 명함의 수정페이지로 이동
                                  },
                                  child: Text('수정'),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    child: Card(
                      child: Image.asset(
                        cardImages[index],
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
