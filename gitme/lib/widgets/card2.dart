import 'package:flutter/material.dart';

class BusinessCardData2 {
  final String name;
  final String jobTitle;
  final String contactInfo;
  final String techStack;
  final String call;
  final String introduce;
  final String followers;
  final String stared;
  final String commit;

  BusinessCardData2({
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


class BusinessCard2 extends StatelessWidget {
  final BusinessCardData2 data;

  BusinessCard2(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.8,
      height: 400,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Color(0xFF9BB7FF),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/jjj.png',
              fit: BoxFit.cover,
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              "jife98",
              style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("commit: 700", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.04)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("star: 98", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.04)),
                SizedBox(width: screenWidth * 0.02),
                Text("PR: 100K", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.04)),
              ],
            ),
            SizedBox(height: screenWidth * 0.01),
            Divider(color: Colors.white),
            SizedBox(height: screenWidth * 0.01),
            Text(
              "안녕하세요 노현이입니다 저는 어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구",
              style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenWidth * 0.01),
            Divider(color: Colors.white),
            SizedBox(height: screenWidth * 0.01),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Phone: ", style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.035)),
                Text("010-0000-0000", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.035)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Email: ", style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.035)),
                Text("sksk02zja@gmail.com", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.035)),
              ],
            ),
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
      border: Border.all(color: Colors.white),
    ),
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    child: Center(
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
    ),
  );
}
