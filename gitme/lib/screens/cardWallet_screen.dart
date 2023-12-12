import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitme/service/apiService.dart';
import 'package:provider/provider.dart';
import '../provider/userData.dart';
import '../service/business_card_data.dart';
import '../widgets/card1.dart';
import '../widgets/card2.dart';
import '../widgets/card3.dart';
import '../widgets/card4.dart';
import 'main_screen.dart';
import 'package:http/http.dart' as http;

class CardWalletScreen extends StatefulWidget {
  static const route = 'card-wallet-screen';

  const CardWalletScreen({super.key});

  @override
  _CardWalletScreenState createState() => _CardWalletScreenState();
}

class _CardWalletScreenState extends State<CardWalletScreen> {

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

  bool isListView = true;

  Map<Map<String, dynamic>, int> originalPositions = {}; // 삭제된 항목의 원래 위치를 저장
  List<Map<String, dynamic>> undoList = []; // 삭제된 항목을 임시로 저장할 리스트

  List<Map<String, dynamic>> tableList = [];

  @override
  void initState() {
    super.initState();
    fetchCardList();
  }

  Future<void> fetchCardList() async {
    final userIdx = Provider.of<UserData>(context, listen: false).userIdx;

    try {
      final response = await http.get(
        Uri.parse(
            'https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/cardWallet/$userIdx'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        tableList = List<Map<String, dynamic>>.from(data);

        for (final cardInfo in tableList) {
          final targetUserIdx = cardInfo['targetUserIdx'];
          final cardInfoResult = await ServerApiService.getCardInfo(
              targetUserIdx);

          cardInfo.addAll({
            'name': utf8.decode(cardInfoResult['name']
                .toString()
                .codeUnits) ?? "",
            'birthdate': cardInfoResult['birthDate'] ?? "",
            'email': cardInfoResult['email'] ?? "",
            'phone': cardInfoResult['phone'] ?? "",
            'introduction': utf8.decode(cardInfoResult['introduction']
                .toString()
                .codeUnits) ?? "",
            'externalLink': Map<String, String>.from(
                cardInfoResult['externalLink'] ?? {}),
            'nickname': cardInfoResult['nickname'] ?? "",
            'followers': cardInfoResult['followers']?.toString() ?? "",
            'following': cardInfoResult['following']?.toString() ?? "",
            'totalStars': cardInfoResult['totalStars']?.toString() ?? "",
            'totalCommits': cardInfoResult['totalCommits']?.toString() ?? "",
            'avatarUrl': cardInfoResult['avatarUrl'] ?? "",
            'languages': Map<String, int>.from(
                cardInfoResult['languages'] ?? {}),
          });
        }

        setState(() {});
        print(tableList);
      } else {
        throw Exception('Failed to load card list');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


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
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '보관된 명함을 검색해보세요',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // 검색 기능 구현
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1.0,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/cardlist.png', // 이미지 경로
                      width: 50, // 이미지 너비
                      height: 50, // 이미지 높이
                    ),
                    SizedBox(width: 5), // 이미지와 텍스트 사이 간격 조정
                    Text(
                      '${tableList.length}개 보관중', // 테이블 수 표시
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFF676A66),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isListView = !isListView;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        isListView ? '보기 정렬' : '보기 정렬',
                        style: TextStyle(
                          color: Color(0xFF676A66),
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(width: 5),
                      Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Icon(
                          isListView ? Icons.view_list : Icons.grid_view,
                          color: Color(0xFF676A66),
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isListView
                ? ListView.builder(
                    itemCount: tableList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: Key(tableList[index]['name']),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            if (direction == DismissDirection.endToStart) {
                              int originalIndex = tableList.indexOf(tableList[index]);
                              originalPositions[tableList[index]] = originalIndex;

                              undoList.add(tableList[index]);
                              tableList.removeAt(index);
                            }
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Expanded(
                                    child: Text('삭제되었습니다'),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (undoList.isNotEmpty) {
                                          var lastUndo = undoList.removeLast();
                                          var originalPosition =
                                              originalPositions[lastUndo];
                                          if (originalPosition != null) {
                                            tableList.insert(
                                                originalPosition, lastUndo);
                                          } else {
                                            // originalPosition이 null일 경우 기본값(예를 들어 리스트의 맨 끝)을 설정하여 insert를 실행합니다.
                                            tableList.add(lastUndo);
                                          }
                                          originalPositions.remove(lastUndo);
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.undo,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.black.withOpacity(0.6),
                            ),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                final cardData = BusinessCardData(
                                  name: tableList[index]['name'] ?? "",
                                  birthdate: tableList[index]['birthdate'] ?? "",
                                  email: tableList[index]['email'] ?? "",
                                  phone: tableList[index]['phone'] ?? "",
                                  introduction: tableList[index]['introduction'] ?? "",
                                  externalLink: Map<String, String>.from(tableList[index]['externalLink'] ?? {}),
                                  nickname: tableList[index]['nickname'] ?? "",
                                  followers: tableList[index]['followers']?.toString() ?? "",
                                  following: tableList[index]['following']?.toString() ?? "",
                                  totalStars: tableList[index]['totalStars']?.toString() ?? "",
                                  totalCommits: tableList[index]['totalCommits']?.toString() ?? "",
                                  avatarUrl: tableList[index]['avatarUrl'] ?? "",
                                  languages: Map<String, int>.from(tableList[index]['languages'] ?? {}),
                                  skillProficiency: tableList[index]['skillProficiency'] ?? "",
                                );

                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildBusinessCard(tableList[index]['template'] - 1, cardData),
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black.withOpacity(0.6),
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 140,
                            margin: EdgeInsets.only(
                                left: 3.0, right: 3.0, bottom: 0),
                            child: Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tableList[index]['name'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            tableList[index]['introduction'] ?? "",
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              if (tableList[index]['languages'] != null)
                                                Text(
                                                  tableList[index]['languages']!.keys.take(3).map((key) => '#$key').join(' '),
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: Image.network(
                                        tableList[index]['avatarUrl'] ?? "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: cardImages.length,
                    itemBuilder: (context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Image.asset(cardImages[index]),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      Text('선택한 명함을 삭제하시겠습니까?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .pop(); // 안쪽 대화 상자 닫기
                                                        Navigator.of(context)
                                                            .pop(); // 바깥쪽 이미지 대화 상자 닫기
                                                      },
                                                      child: Text('취소'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          cardImages
                                                              .removeAt(index);
                                                        });
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .pop(); // 안쪽 대화 상자 닫기
                                                        Navigator.of(context)
                                                            .pop(); // 바깥쪽 이미지 대화 상자 닫기
                                                      },
                                                      child: Text('삭제'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.delete),
                                          // Use "delete" icon
                                          color:
                                              Colors.red, // Define icon color
                                        ),
                                      ],
                                    ),
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


Widget _buildBusinessCard(int templateIdx, BusinessCardData cardData) {
  switch (templateIdx + 1) {
    case 1:
      return BusinessCard1(cardData);
    case 2:
      return BusinessCard2(cardData);
    case 3:
      return BusinessCard3(cardData);
    case 4:
      return BusinessCard4(cardData);
    default:
      throw Exception("Invalid card index");
  }
}