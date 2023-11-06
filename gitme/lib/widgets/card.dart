import 'package:flutter/material.dart';

class BusinessCardData {
  final String name;
  final String jobTitle;
  final String contactInfo;
  final String techStack;
  final String call;
  final String introduce;

  BusinessCardData({required this.name, required this.jobTitle, required this.contactInfo, required this.call, required this.techStack, required this.introduce});
}

List<BusinessCardData> dummyData = [
  BusinessCardData(
    name: "John Doe",
    jobTitle: "Software Developer",
    contactInfo: "johndoe@example.com",
    call: "010-0000-0000",
    techStack: "java",
    introduce: "hi"
  ),
  // 다른 더미 데이터 추가
];

class BusinessCard extends StatelessWidget {
  final BusinessCardData data;

  BusinessCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Container(
            color: Colors.blue, // 배경색 설정
            child: ListTile(
              title: Text(data.name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              subtitle: Text(data.jobTitle, style: TextStyle(color: Colors.white)),
            ),
          ),
          Divider(color: Colors.blue),
          ListTile(
            title: Text('Tech Stack', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(data.techStack, style: TextStyle(color: Colors.green)),
          ),
          ListTile(
            title: Text('call', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(data.call, style: TextStyle(color: Colors.blue)),
          ),
          ListTile(
            title: Text('Introduce', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(data.introduce),
          ),
        ],
      ),
    );
  }
}
