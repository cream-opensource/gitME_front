import 'package:flutter/material.dart';

import '../widgets/custom_drawer_btn.dart';
import '../widgets/main_drawer.dart';

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
      appBar: null,
      body: Stack(
        children: [
          CustomDrawerBtn(),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: GridView.builder(
              padding: EdgeInsets.only(bottom: 20),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
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
                                  onPressed: (
                                      // #TODO:  index에 맞는 명함의 수정페이지로 이동
                                      ) {},
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
                    )
                );
              },
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
