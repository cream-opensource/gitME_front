import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/widgets/github_button.dart';
import 'package:gitme/widgets/introduceFormFieldComponent.dart';
import 'package:gitme/widgets/textFormFieldComponent.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/userData.dart';
import '../widgets/githubLoginWebView.dart';

class LanguageScreen extends StatelessWidget {
  static final route = 'join-screen';

  final formKey = GlobalKey<FormState>();
  bool isLinked = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController introduceController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset(
              'assets/back_button.png', // 이미지 경로
              width: 20, // 이미지 너비
              height: 20, // 이미지 높이
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(MainScreen.route);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Next", style: TextStyle(
                fontSize: 36,
                color: Color(0xFF56CC94),
                fontFamily: 'DarkerGrotesque',
                fontWeight: FontWeight.w800,
                letterSpacing: -0.8,
              )),
              Text("Turn!", style: TextStyle(
                fontSize: 36,
                color: Color(0xFF56CC94),
                fontFamily: 'DarkerGrotesque',
                fontWeight: FontWeight.w800,
                letterSpacing: -0.8,
              )),
              SizedBox(height: 30), // 예시로 간격 추가
              Text("노현이 님이 github 내 사용 언어", style: TextStyle(fontSize: 16, color: Color(0xFF8D919F))),
              SizedBox(height: 20), // 예시로 간격 추가
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRoundedText("Word1"),
                  SizedBox(width: 5),
                  _buildRoundedText("Word1"),
                  SizedBox(width: 5),
                  _buildRoundedText("Word1"),// Add more Text widgets as needed
                ],
              ),
              SizedBox(height: 13),
              Divider(),
            ],
          ),
        )
    );
  }

  Future<void> sendUserDataToServer(
      BuildContext context,
      String name, String phone, String email, String birthdate,
      ) async {
    UserData userData = Provider.of<UserData>(context, listen: false);
    String? accessToken = userData.accessToken;
    String? kakaoId = userData.kakaoId?.toString();

    final Map<String, dynamic> data = {
      'kakaoId' : kakaoId ?? '',
      'name': name ?? '',
      'phone': phone ?? '',
      'email': email ?? '',
      'birthDate': birthdate ?? '',
      'gitAccessToken': accessToken ?? '',
      "externalLink": {
        "notion1": "test1",
        "notion2": "test2"
      }
    };

    final String jsonData = jsonEncode(data);

    final response = await http.post(
      Uri.parse('https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/signUp'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );
    print('보낼 데이터 확인: $data');

    if (response.statusCode == 201) {
      print(jsonData);
      print('보낼 데이터 확인: $jsonData');
      print('데이터: ${response.body}');
      Navigator.pushReplacementNamed(
        context,
        MainScreen.route,
      );
    } else {
      print('요청 실패: ${response.reasonPhrase}');
    }
  }
}


Widget _buildRoundedText(String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Color(0xFF56CC94)), // 테두리 색상 설정
      color: Color(0xFF56CC94)
    ),
    padding: EdgeInsets.fromLTRB(10, 8, 10, 8), // 텍스트와 테두리 간격 설정
    child: Center(
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
    ),
  );
}

// Widget selctionButton()(String text) {
//   return Container(
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(color: Color(0xFF56CC94)), // 테두리 색상 설정
//         color: Color(0xFF56CC94)
//     ),
//     padding: EdgeInsets.fromLTRB(10, 8, 10, 8), // 텍스트와 테두리 간격 설정
//     child: Center(
//       child: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
//     ),
//   );
// }
//
