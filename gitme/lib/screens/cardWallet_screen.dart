import 'package:flutter/material.dart';
import 'main_screen.dart';

class CardWalletScreen extends StatelessWidget {
  static final route = 'card-wallet-screen';

  final List<Map<String, dynamic>> tableList = [
    {
      'name': '이이섭',
      'text': '소프트웨어공학 교수',
      'stack': '#Spring #Backend',
      'imagePath': 'assets/LLS.png',
    },
    {
      'name': '황준하',
      'text': 'JS, Spring 개발자 입니다.',
      'stack': '#Swift #백수',
      'imagePath': 'assets/HJH.png',
    },
    {
      'name': '윤현주',
      'text': '커피를 좋아하는 개발자.',
      'stack': '#Spring #금오공대 #학생',
      'imagePath': 'assets/YHJ.png',
    },
    {
      'name': '붕어빵',
      'text': '따끈한 겨울 간식',
      'stack': '#python #C++',
      'imagePath': 'assets/BBANG.png',
    },
    {
      'name': '노현이',
      'text': 'Back',
      'stack': '#dart #휴학생',
      'imagePath': 'assets/LLS.png',
    },
    {
      'name': '김지연',
      'text': 'Front',
      'stack': '@front #공무원 #JAVA',
      'imagePath': 'assets/HJH.png',
    },
    {
      'name': '최훈',
      'text': '커피를 좋아하는 개발자.',
      'stack': '#Spring #금오공대 #학생',
      'imagePath': 'assets/YHJ.png',
    },
    {
      'name': '조재중',
      'text': '따끈한 겨울 간식',
      'stack': '#python #C++',
      'imagePath': 'assets/BBANG.png',
    },
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
          '보관중인 명함',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20), // 조절 가능한 여백
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '보관된 명함을 검색해보세요',
                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // 검색 기능 구현
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.blue, // 포커스를 받지 않았을 때 파란색 테두리
                    width:1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.black, // 포커스를 받았을 때 검정색 테두리
                    width: 1.0,
                  ),
                ),
              ),
              onChanged: (value) {
                // 검색 기능 구현
              },
            ),

          ),
          SizedBox(height: 30),
          Row(
            children: [
              Image.asset(
                'assets/cardlist.png', // 이미지 경로
                width: 50, // 이미지 너비
                height: 50, // 이미지 높이
              ),
              Text(
                '${tableList.length}개 보관중', // 테이블 수 표시
                textAlign: TextAlign.start, // 왼쪽 정렬
                style: TextStyle(
                  color: Color(0xFF676A66),
                  fontSize: 15, // 텍스트 크기 조정
                  fontWeight: FontWeight.bold, // 텍스트 굵기 조정
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tableList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 140,
                  margin: EdgeInsets.only(left: 3.0, right: 3.0, bottom: 0),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tableList[index]['name'],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  tableList[index]['text'],
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  tableList[index]['stack'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.asset(
                              tableList[index]['imagePath'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
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