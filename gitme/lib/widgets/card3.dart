import 'package:flutter/material.dart';

class BusinessCardData3 {
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

  BusinessCardData3({
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

class BusinessCard3 extends StatelessWidget {
  final BusinessCardData3 data;

  BusinessCard3(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.8,
      height: 400,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Color(0xFF7765F9),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(data.name, style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.06),),
            Text(data.nickname, style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.06, fontFamily: 'DarkerGrotesque'),),
            // Text(data.name, style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold),),
            Text(data.name, style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold),),
            SizedBox(height: screenWidth * 0.03),
            Text("Stack", style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03),),
            SizedBox(height: screenWidth * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
//                 if (data.languages != null)
//                   for (var entry in data.languages!.entries.take(2))
//                     _buildRoundedText("${entry.key}: ${entry.value}"),

                _buildRoundedText("Spring", screenWidth),
                SizedBox(width: screenWidth * 0.01),
                _buildRoundedText("Node.js", screenWidth),
                SizedBox(width: screenWidth * 0.01),
                _buildRoundedText("react", screenWidth), // Add more Text widgets as needed
              ],
            ),
            SizedBox(height: screenWidth * 0.03),
            Text("Info", style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03),),
            SizedBox(height: screenWidth * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // _buildRoundedText(data.commit, screenWidth),
                _buildRoundedText("Commits: ${data.totalCommits}", screenWidth),
                SizedBox(width: screenWidth * 0.01),
                // _buildRoundedText("Star: 17K"),
                SizedBox(width: screenWidth * 0.01),
                _buildRoundedText("Followers: ${data.followers}", screenWidth), // Add more Text widgets as needed
              ],
            ),
            SizedBox(height: screenWidth * 0.03),
            Divider(color: Colors.white),
            SizedBox(height: screenWidth * 0.03),
//                     Text(data.externalLink?.values.join(', ') ?? "",
            Text(
              "안녕하세요 노현이입니다 어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구",
              style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildRoundedText(String text, double screenWidth) {
  return Padding(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white),
      ),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.016),
      child: Center(
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03)),
      ),
    ),
    padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
  );
}
