import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitme/screens/language_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/widgets/github_button.dart';
import 'package:gitme/widgets/introduceFormFieldComponent.dart';
import 'package:gitme/widgets/textFormFieldComponent.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/userData.dart';
import '../widgets/githubLoginWebView.dart';

class ExternalLinkScreen extends StatelessWidget {
  static final route = 'externalLink-screen';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 36,
                          color: Color(0xFF56CC94),
                          fontFamily: 'DarkerGrotesque',
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                        ),
                      ),
                      Text(
                        "Turn",
                        style: TextStyle(
                          fontSize: 36,
                          color: Color(0xFF56CC94),
                          fontFamily: 'DarkerGrotesque',
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "2 / 3",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF56CC94),
                      fontFamily: 'DarkerGrotesque',
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                    ),
                  ),
                ],
              ),
              Text("외부 링크는\n내가 소개하고 싶은 웹페이지예요!\n최대 3개까지 등록 가능해요",
                style: TextStyle(
                  fontSize: 16.5,
                  color: Color(0xFF8D919F),
                  fontFamily: 'DarkerGrotesque',
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
                textAlign: TextAlign.center, // 가운데 정렬 추가
              ),
              SizedBox(height: 20), // 예시로 간격 추가

              
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LanguageScreen()),
                        );
                      },
                      child: Text('다음'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF56CC94),
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // 모서리 조절
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
