import 'package:flutter/material.dart';

class BusinessCardData4 {
  final String name;
  final String jobTitle;
  final String contactInfo;
  final String techStack;
  final String call;
  final String introduce;
  final String followers;
  final String stared;
  final String commit;

  BusinessCardData4({
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

class BusinessCard4 extends StatelessWidget {
  final BusinessCardData4 data;

  BusinessCard4(this.data, {super.key});

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
        gradient: LinearGradient(
          colors: [
            Color(0xFFDBC3EA), // Pink color
            Color(0xFFDBC3EA), // Pink color
            Color(0xFFFFFFFF), // White color
            Color(0xFFFFFFFF), // White color

          ],
          stops: [0.0, 0.6, 0.4, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        color: Color(0xFFDBC3EA),
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

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/jjj.png',
                  fit: BoxFit.cover,
                  width: 40, // 원하는 너비로 조절
                  height: 40, // 원하는 높이로 조절
                ),
                SizedBox(width: 10,),
                Text("m-a-king", style: TextStyle(
                    fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'DarkerGrotesque'
                  ),
                )
              ],
            ),
            SizedBox(height: 10),

            Text("멋진 청년.\n휼륭한 웹 개발자가 되기 위한 수련 중.\nI am 조재중이에요 ~", style: TextStyle(
                fontSize: 14, color: Colors.white, fontFamily: 'DarkerGrotesque'),
            ),
            SizedBox(height: 50,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("tistory"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13), // 모서리 조절
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("notion"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13), // 모서리 조절
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("기타"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13), // 모서리 조절
                      ),
                    ),
                  ),
                  // Add more buttons as needed
                ],
              ),
            ),
            SizedBox(height: 30,),
            Text("Stack", style: TextStyle(color: Color(0xFF8B8B91), fontSize: 13)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Spring"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // 모서리 조절
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Node.js"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // 모서리 조절
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Kotlin"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // 모서리 조절
                      ),
                    ),
                  ),
                  // Add more buttons as needed
                ],
              ),
            ),
            SizedBox(height: 8,),
            Text("Info", style: TextStyle(color: Color(0xFF8B8B91), fontSize: 13)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Text(
                          "Commit",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "369",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // 모서리 조절
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Text(
                          "Stars",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "25",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // 모서리 조절
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Text(
                          "PR",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "104",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // 모서리 조절
                      ),
                    ),
                  ),
                  // Add more buttons as needed
                ],
              ),
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
