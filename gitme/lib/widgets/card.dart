import 'package:flutter/material.dart';

class BusinessCardData {
  final String name;
  final String jobTitle;
  final String contactInfo;
  final String techStack;
  final String call;
  final String introduce;
  final String followers;
  final String stared;
  final String commit;

  BusinessCardData({
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

class BusinessCard extends StatelessWidget {
  final BusinessCardData data;

  BusinessCard(this.data, {super.key});

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
            Colors.indigo.withOpacity(0.6),
            Colors.indigo.withOpacity(0.6),
            Colors.white,
          ],
          stops: [0.0, 0.7, 0.7],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20.0),
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
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: AssetImage('assets/cat.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 135),
          Row(
            children: [
              SizedBox(width: 10),
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage('assets/mark2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5),
              Text(
                data.introduce,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 80),
              InkWell(
                onTap: () {
                  // 첫 번째 버튼 클릭 시 동작할 내용을 추가하세요.
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage('assets/tistory.png'),
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
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage('assets/notion.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
          //SizedBox(height: 20),
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
