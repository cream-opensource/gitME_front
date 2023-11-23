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

  BusinessCardData2({required this.name, required this.jobTitle, required this.contactInfo, required this.call,
    required this.techStack, required this.introduce, required this.followers, required this.stared, required this.commit});
}


class BusinessCard2 extends StatelessWidget {
  final BusinessCardData2 data;

  BusinessCard2(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      // 세로 비즈니스 카드의 너비 설정
      height: 500,
      // 세로 비즈니스 카드의 높이 설정
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 30),
      // 비즈니스 카드를 아래로 내리기 위한 여백 설정
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo.withOpacity(0.6),
            Colors.indigo.withOpacity(0.6),
            Colors.white, // 하얀색
          ],
          stops: [0.0, 0.7, 0.7], // 각 색상의 정지점 (0.66이면 2/3 지점에서 색이 변경됩니다.)
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.center, // 이미지를 가로 방향으로 중앙에 배치
            child: Container(
              width: 250, // 이미지의 너비
              height: 100, // 이미지의 높이
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: AssetImage('assets/kakao.png'), // 이미지 경로 설정
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 160),
          Container(
            width: 80,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage('assets/mark2.png'), // 이미지 경로 설정
                fit: BoxFit.cover,
              ),
            ),
          ),
          //SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.introduce,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 80), // 간격 조정
              InkWell(
                onTap: () {
                  // 버튼 클릭 시 동작할 내용을 추가하세요.
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage('assets/tistory.png'), // 버튼 이미지 경로 설정
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // 버튼 클릭 시 동작할 내용을 추가하세요.
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage('assets/notion.png'), // 버튼 이미지 경로 설정
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              data.name,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              data.contactInfo,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              data.call,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
