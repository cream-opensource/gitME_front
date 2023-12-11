import 'package:flutter/material.dart';

class BusinessCardData2 {
  final String name;
  final String birthdate;
  final String email;
  final String phone;
  final String introduce;
  final Map<String, dynamic>? externalLink;
  final String nickname;
  final String followers;
  final String following;
  final String totalStars;
  final String totalCommits;
  final String avatarUrl;
  final Map<String, dynamic>? languages;

  BusinessCardData2({
    required this.name,
    required this.birthdate,
    required this.email,
    required this.phone,
    required this.introduce,
    required this.externalLink,
    required this.nickname,
    required this.followers,
    required this.following,
    required this.totalStars,
    required this.totalCommits,
    required this.avatarUrl,
    required this.languages,
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
            Image.network(
              data.avatarUrl,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              data.nickname,
              style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("commit: ${data.totalCommits}", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.04)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("star: ${data.totalStars}", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.04)),
                SizedBox(width: screenWidth * 0.02),
                Text("fllower: ${data.followers}", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.04)),
              ],
            ),
            SizedBox(height: screenWidth * 0.01),
            Divider(color: Colors.white),
            SizedBox(height: screenWidth * 0.01),
            Text(
              data.introduce,
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
                Text(data.phone, style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.035)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Email: ", style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.035)),
                Text(data.email, style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.035)),
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
