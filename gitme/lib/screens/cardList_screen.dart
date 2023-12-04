import 'package:flutter/material.dart';
import 'main_screen.dart';

class CardListScreen extends StatefulWidget {
  static final route = 'cardList-screen';

  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
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

  List<bool> selectedItems = List.generate(8, (index) => false);
  List<int> selectedGridIndices = [];

  int? draggingIndex;
  int? newPosition;

  void toggleSelection(int index) {
    setState(() {
      if (selectedItems[index]) {
        if (selectedGridIndices.contains(index)) {
          selectedGridIndices.remove(index);
        } else {
          selectedGridIndices.add(index);
        }
      }
    });
  }

  void deleteSelectedItems() {
    setState(() {
      selectedGridIndices.sort((a, b) => b.compareTo(a));
      selectedGridIndices.forEach((index) {
        cardImages.removeAt(index);
      });
      selectedGridIndices.clear();
      selectedItems = List.generate(8, (index) => false);
    });
  }

  void resetSelection() {
    setState(() {
      selectedGridIndices.clear();
      selectedItems = List.generate(8, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F4F4),
        leading: IconButton(
          icon: Image.asset(
            'assets/back_button.png',
            width: 20,
            height: 20,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 16),
                    Image.asset(
                      'assets/cardlist.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 5),
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
                TextButton(
                  onPressed: () {
                    if (!selectedItems.any((isSelected) => isSelected)) {
                      setState(() {
                        selectedItems = List.generate(8, (index) => true);
                      });
                    } else {
                      if (selectedGridIndices.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('선택한 명함을 삭제하시겠습니까?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    resetSelection(); // '취소' 누를 때 선택 초기화
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('취소'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteSelectedItems();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('삭제'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // '삭제'와 '완료' 상태 전환
                        setState(() {
                          selectedItems = List.generate(8, (index) => false);
                        });
                      }
                    }
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (!selectedItems.any((isSelected) => isSelected)) {
                        return Colors.red;
                      } else {
                        return Colors.blue;
                      }
                    }),
                  ),
                  child: Text(!selectedItems.any((isSelected) => isSelected) ? '삭제' : '완료'),
                ),
              ],
            ),
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
                    setState(() {
                      if (selectedItems[index]) {
                        if (selectedGridIndices.contains(index)) {
                          selectedGridIndices.remove(index);
                        } else {
                          selectedGridIndices.add(index);
                        }
                      }
                    });
                  },
                  child: Card(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedGridIndices.contains(index)
                                  ? Colors.red
                                  : Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Image.asset(
                                cardImages[index],
                                width: 150,
                                height: 150,
                              ),
                              if (selectedItems[index])
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Icon(
                                    Icons.check,
                                    size: 20,
                                    color: selectedGridIndices.contains(index)
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
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
