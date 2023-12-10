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
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
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
        padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data.nickname, style: TextStyle(color: Colors.white, fontSize: 22),),
            Text(data.name, style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),),
            SizedBox(height: 20),
            Text("stack", style: TextStyle(color: Colors.white, fontSize: 17),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (data.languages != null)
                  for (var entry in data.languages!.entries.take(2))
                    _buildRoundedText("${entry.key}: ${entry.value}"),
              ],
            ),
            SizedBox(height: 20),
            Text("Info", style: TextStyle(color: Colors.white, fontSize: 17),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoundedText("Commits: ${data.totalCommits}"),
                // SizedBox(width: 5),
                // _buildRoundedText("Star: 17K"),
                SizedBox(width: 5),
                _buildRoundedText("Followers: ${data.followers}"),// Add more Text widgets as needed
              ],
            ),
            SizedBox(height: 20,),
            Text(data.externalLink?.values.join(', ') ?? "",
            style: TextStyle(color: Colors.white, fontSize: 16, ), textAlign: TextAlign.center),

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
