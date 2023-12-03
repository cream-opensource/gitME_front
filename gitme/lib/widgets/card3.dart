import 'package:flutter/material.dart';

class BusinessCardData3 {
  final String name;
  final String jobTitle;
  final String contactInfo;
  final String techStack;
  final String call;
  final String introduce;
  final String followers;
  final String stared;
  final String commit;

  BusinessCardData3({
    required this.name,
    required this.jobTitle,
    required this.contactInfo,
    required this.call,
    required this.techStack,
    required this.introduce,
    required this.followers,
    required this.stared,
    required this.commit,
  });
}

class BusinessCard3 extends StatelessWidget {
  final BusinessCardData3 data;

  BusinessCard3(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      height: 400,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Color(0xFF7765F9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data.name, style: TextStyle(color: Colors.white, fontSize: 22),),
            Text(data.name, style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),),
            SizedBox(height: 20),
            Text("stack", style: TextStyle(color: Colors.white, fontSize: 17),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoundedText("Word1"),
                SizedBox(width: 5),
                _buildRoundedText("Word1"),
                SizedBox(width: 5),
                _buildRoundedText("Word1"),// Add more Text widgets as needed
              ],
            ),
            SizedBox(height: 20),
            Text("Info", style: TextStyle(color: Colors.white, fontSize: 17),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoundedText(data.commit),
                // SizedBox(width: 5),
                // _buildRoundedText("Star: 17K"),
                SizedBox(width: 5),
                _buildRoundedText("PR: 900"),// Add more Text widgets as needed
              ],
            ),
            SizedBox(height: 20,),
            Text("안녕하세요 노현이입니다 저는 어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구",
            style: TextStyle(color: Colors.white, fontSize: 16, ), textAlign: TextAlign.center),

          ],
        ),
      ),
    );
  }
}


Widget _buildRoundedText(String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white), // 테두리 색상 설정
    ),
    padding: EdgeInsets.fromLTRB(10, 8, 10, 8), // 텍스트와 테두리 간격 설정
    child: Center(
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
    ),
  );
}
