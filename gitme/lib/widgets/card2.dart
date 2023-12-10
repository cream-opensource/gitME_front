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
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
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
        padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/jjj.png',
              fit: BoxFit.cover,
            ),
            Text("jife98", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("commit: 700", style: TextStyle(color: Color(0xFF8B8B91), fontSize: 16)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("star: 98", style: TextStyle(color: Color(0xFF8B8B91), fontSize: 16)),
                SizedBox(width: 8,),
                Text("PR: 100K", style: TextStyle(color: Color(0xFF8B8B91), fontSize: 16)),
              ],
            ),
            SizedBox(height: 8,),
            Divider(color: Colors.white,),
            SizedBox(height: 8,),
            Text("안녕하세요 노현이입니다 저는 어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구",
                style: TextStyle(color: Colors.white, fontSize: 14, ), textAlign: TextAlign.center),
            SizedBox(height: 8,),
            Divider(color: Colors.white,),
            SizedBox(height: 8,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Phone: ", style: TextStyle(color: Color(0xFF8B8B91), fontSize: 16)),
                Text("010-0000-0000", style: TextStyle(color: Color(0xFF8B8B91), fontSize: 16)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Email: ", style: TextStyle(color: Color(0xFF8B8B91), fontSize: 16)),
                Text("sksk02zja@gmail.com", style: TextStyle(color: Color(0xFF8B8B91), fontSize: 16)),
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
      border: Border.all(color: Colors.white), // 테두리 색상 설정
    ),
    padding: EdgeInsets.fromLTRB(10, 8, 10, 8), // 텍스트와 테두리 간격 설정
    child: Center(
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
    ),
  );
}
