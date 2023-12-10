import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitme/screens/externallink_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/widgets/introduceFormFieldComponent.dart';
import 'package:gitme/widgets/textFormFieldComponent.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/userData.dart';

class JoinScreen extends StatelessWidget {
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
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/back_button.png',
            width: 20,
            height: 20,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(MainScreen.route);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
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
                      "Let's",
                      style: TextStyle(
                        fontSize: 36,
                        color: Color(0xFF56CC94),
                        fontFamily: 'DarkerGrotesque',
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                      ),
                    ),
                    Text(
                      "Start!",
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
                  "1 / 3",
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
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormFieldComponent(
                        TextInputType.text,
                        TextInputAction.next,
                        "ex. 홍길동",
                        8,
                        "이름을 입력하세요",
                        nameController,
                            (value) => nameController.text = value!,
                        '이름',
                      ),
                      TextFormFieldComponent(
                        TextInputType.datetime,
                        TextInputAction.next,
                        "ex. 19980101",
                        8,
                        "생년월일을 입력하세요",
                        birthdateController,
                            (value) => birthdateController.text = value!,
                        '생년월일',
                      ),
                      TextFormFieldComponent(
                        TextInputType.phone,
                        TextInputAction.next,
                        "ex. 01012345678",
                        11,
                        "'-'없이 숫자로만 입력하세요",
                        phoneController,
                            (value) => phoneController.text = value!,
                        '전화번호',
                      ),
                      TextFormFieldComponent(
                        TextInputType.emailAddress,
                        TextInputAction.next,
                        "ex. gildong@gmail.com",
                        20,
                        "이메일을 입력하세요",
                        emailController,
                            (value) => emailController.text = value!,
                        '이메일',
                      ),
                      IntroduceFormFieldComponent(
                        TextInputType.text,
                        TextInputAction.done,
                        "자기소개",
                        50,
                        "자기소개 글을 작성해주세요",
                        introduceController,
                            (value) => introduceController.text = value!,
                        '자기소개',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            UserData userData = Provider.of<UserData>(context, listen: false);

                            formKey.currentState?.save();
                            String name = nameController.text;
                            String phone = phoneController.text;
                            String email = emailController.text;
                            String birthdate = birthdateController.text;
                            String introduce = introduceController.text;

                            print('Name: $name');
                            print('Phone: $phone');
                            print('Email: $email');
                            print('Birthdate: $birthdate');
                            print('introduce: $introduce');

                            // await sendUserDataToServer(context, name, phone, email, birthdate);
                            //
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => ExternalLinkScreen(name: name, phone: phone, email: email, birthdate: birthdate, introduce: introduce )),
                            // );

                            userData.setJoinData(name, phone, email, birthdate, introduce);

                            Navigator.pushReplacementNamed(
                              context,
                              ExternalLinkScreen.route,
                            );
                          }
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
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