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
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFDBC3EA),
            Color(0xFFDBC3EA),
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
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
        padding: EdgeInsets.all(screenWidth * 0.08),
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
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  "m-a-king",
                  style: TextStyle(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'DarkerGrotesque',
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.01),
            Text(
              "멋진 청년.\n휼륭한 웹 개발자가 되기 위한 수련 중.\nI am 조재중이에요 ~",
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                color: Colors.white,
                fontFamily: 'DarkerGrotesque',
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("tistory"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFD2AFE3),
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontSize: screenWidth * 0.03),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("notion"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFD2AFE3),
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontSize: screenWidth * 0.03),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("기타"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFD2AFE3),
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontSize: screenWidth * 0.03),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                      ),
                    ),
                    // Add more buttons as needed
                  ],
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            Text("Stack", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.03)),
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
                      textStyle: TextStyle(fontSize: screenWidth * 0.03),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Node.js"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(fontSize: screenWidth * 0.03),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Kotlin"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      textStyle: TextStyle(fontSize: screenWidth * 0.03),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                    ),
                  ),
                  // Add more buttons as needed
                ],
              ),
            ),
            SizedBox(height: screenWidth * 0.008),
            Text("Info", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.03)),
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
                            fontSize: screenWidth * 0.02,
                          ),
                        ),
                        Text(
                          "369",
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Text(
                          "Stars",
                          style: TextStyle(
                            fontSize: screenWidth * 0.02,
                          ),
                        ),
                        Text(
                          "25",
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Text(
                          "PR",
                          style: TextStyle(
                            fontSize: screenWidth * 0.02,
                          ),
                        ),
                        Text(
                          "104",
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
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
