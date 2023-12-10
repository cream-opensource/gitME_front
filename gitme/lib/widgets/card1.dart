import 'package:flutter/material.dart';

class BusinessCardData1 {
  final String name;
  final String jobTitle;
  final String contactInfo;
  final String techStack;
  final String call;
  final String introduce;
  final String followers;
  final String stared;
  final String commit;

  BusinessCardData1({
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

class BusinessCard1 extends StatelessWidget {
  final BusinessCardData1 data;

  BusinessCard1(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4E6DE1),
            Color(0xFF4E6DE1),
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
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/cat.png',
              fit: BoxFit.cover,
              height: screenWidth * 0.3,
            ),
            SizedBox(height: screenWidth * 0.2),
            Container(
              width: screenWidth * 0.2,
              height: screenWidth * 0.04,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage('assets/mark2.png'),
                  fit: BoxFit.cover,
                ),
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
                      "glidong",
                      style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.08, fontWeight: FontWeight.w800, fontFamily: 'DarkerGrotesque'),
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        // 두 번째 버튼 클릭 시 동작할 내용을 추가하세요.
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: AssetImage('assets/notion.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // 두 번째 버튼 클릭 시 동작할 내용을 추가하세요.
                      },
                      child: Container(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: AssetImage('assets/tistory.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                      "홍길동",
                      style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.06, fontWeight: FontWeight.w700,),
                    ),
                    Text(
                      "glidong@gmail.com",
                      style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.03,),
                    ),
                    Text(
                      "010-1234-5678",
                      style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.03,),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),










      // child: Padding(
      //   padding: EdgeInsets.all(screenWidth * 0.08),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       SizedBox(height: 20),
      //       Align(
      //         alignment: Alignment.center,
      //         child: Container(
      //           width: screenWidth * 0.5,
      //           height: screenWidth * 0.25,
      //           decoration: BoxDecoration(
      //             shape: BoxShape.rectangle,
      //             borderRadius: BorderRadius.circular(5),
      //             image: DecorationImage(
      //               image: AssetImage('assets/jjj.png'),
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(height: screenWidth * 0.2),
      //       Row(
      //         children: [
      //           SizedBox(width: screenWidth * 0.02),
      //           Container(
      //             width: screenWidth * 0.2,
      //             height: screenWidth * 0.04,
      //             decoration: BoxDecoration(
      //               shape: BoxShape.rectangle,
      //               image: DecorationImage(
      //                 image: AssetImage('assets/mark2.png'),
      //                 fit: BoxFit.cover,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           SizedBox(width: screenWidth * 0.01),
      //           Expanded(
      //             child: Text(
      //               data.introduce,
      //               style: TextStyle(
      //                 fontSize: screenWidth * 0.06,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ),
      //           SizedBox(width: screenWidth * 0.1),
      //           InkWell(
      //             onTap: () {
      //               // 첫 번째 버튼 클릭 시 동작할 내용을 추가하세요.
      //             },
      //             child: Container(
      //               width: screenWidth * 0.06,
      //               height: screenWidth * 0.06,
      //               decoration: BoxDecoration(
      //                 shape: BoxShape.rectangle,
      //                 image: DecorationImage(
      //                   image: AssetImage('assets/tistory.png'),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //           ),
      //           InkWell(
      //             onTap: () {
      //               // 두 번째 버튼 클릭 시 동작할 내용을 추가하세요.
      //             },
      //             child: Container(
      //               width: screenWidth * 0.05,
      //               height: screenWidth * 0.05,
      //               decoration: BoxDecoration(
      //                 shape: BoxShape.rectangle,
      //                 image: DecorationImage(
      //                   image: AssetImage('assets/notion.png'),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //           ),
      //           SizedBox(width: screenWidth * 0.01),
      //         ],
      //       ),
      //       SizedBox(height: screenWidth * 0.05),
      //       Align(
      //         alignment: Alignment.centerRight,
      //         child: Text(
      //           // data.name,
      //           "홍길동",
      //           style: TextStyle(
      //             fontSize: screenWidth * 0.06,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ),
      //       Align(
      //         alignment: Alignment.centerRight,
      //         child: Text(
      //           // data.contactInfo,
      //           "frontEnd",
      //           style: TextStyle(fontSize: screenWidth * 0.025),
      //         ),
      //       ),
      //       Align(
      //         alignment: Alignment.centerRight,
      //         child: Text(
      //           //data.call,
      //           "010-1234-5678",
      //           style: TextStyle(fontSize: screenWidth * 0.025),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

