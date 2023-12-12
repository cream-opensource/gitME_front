import 'package:flutter/material.dart';

import '../service/business_card_data.dart';



class BusinessCard1 extends StatelessWidget {
  final BusinessCardData data;

  BusinessCard1(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.8,
      height: 400,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFE8D589),
            Color(0xFFE8D589),
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
          ],
          stops: [0.0, 0.65, 0.35, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child:
      Padding(
        padding: EdgeInsets.all(screenWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 하는 정도를 조절합니다
              child: Image.network(
                data.avatarUrl ?? 'fallback_url_for_empty_avatar',
                height: 110,
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: screenWidth * 0.2),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (data.languages != null)
                    for (var entry in data.languages!.entries.take(3))
                      _buildRoundedText("${entry.key}: ${entry.value}", screenWidth),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.nickname,
                      style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.08, fontWeight: FontWeight.w800, fontFamily: 'DarkerGrotesque'),
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.1,),
              ],
            ),
            SizedBox(height: screenWidth * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.end  ,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end, // 수정된 부분
                  children: [
                    Text(
                      data.name,
                      style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.06, fontWeight: FontWeight.w700,),
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Text(
                      data.email,
                      style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.03,),
                    ),
                    Text(
                      data.phone,
                      style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.03,),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildRoundedText(String text, double screenWidth) {
  return Padding(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white),
      ),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.016),
      child: Center(
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03)),
      ),
    ),
    padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
  );
}
