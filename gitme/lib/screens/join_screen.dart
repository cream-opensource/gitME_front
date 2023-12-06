import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/widgets/github_button.dart';
import 'package:gitme/widgets/textFormFieldComponent.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/userData.dart';

class JoinScreen extends StatefulWidget {
  static const route = 'join-screen';

  JoinScreen({Key? key}) : super(key: key);

  @override
  _JoinScreenState createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLinked = false;
  bool _isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextFormFieldComponent(
                    TextInputType.text,
                    TextInputAction.next,
                    "ex.홍길동",
                    2,
                    "이름을 입력하세요",
                    nameController,
                        (value) => nameController.text = value!,
                    '이름'
                  ),
                  SizedBox(height: 16.0),
                  TextFormFieldComponent(
                    TextInputType.phone,
                    TextInputAction.next,
                    "ex.01012345678",
                    11,
                    "'-'없이 숫자로만 입력하세요",
                    phoneController,
                        (value) => phoneController.text = value!,
                    '전화번호'
                  ),
                  SizedBox(height: 16.0),
                  TextFormFieldComponent(
                    TextInputType.emailAddress,
                    TextInputAction.next,
                    "ex.gildong@gmail.com",
                    10,
                    "이메일을 입력하세요",
                    emailController,
                        (value) => emailController.text = value!,
                    '이메일'
                  ),
                  SizedBox(height: 16.0),
                  TextFormFieldComponent(
                    TextInputType.datetime,
                    TextInputAction.done,
                    "ex.19980101",
                    8,
                    "생년월일을 입력하세요",
                    birthdateController,
                        (value) => birthdateController.text = value!,
                    '생년월일'
                  ),
                  SizedBox(height: 16.0),
                  GitHubButton(),
                  SizedBox(height: 16.0),
                  _isLoading
                      ? CircularProgressIndicator() // _isLoading이 true일 때만 CircularProgressIndicator를 표시합니다.
                      : SizedBox.shrink(),

                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          setState(() {
                            _isLoading = true;
                          });
                          formKey.currentState?.save();
                          String name = nameController.text;
                          String phone = phoneController.text;
                          String email = emailController.text;
                          String birthdate = birthdateController.text;

                          print('Name: $name');
                          print('Phone: $phone');
                          print('Email: $email');
                          print('Birthdate: $birthdate');

                          await sendUserDataToServer(context, name, phone, email, birthdate);

                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text("가입 완료"),
                    ),
                  ),
                ],
              ),
            ),
          ),
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

    final Map<String, dynamic> signUpData = {
      "kakaoId" : kakaoId ?? '',
      "name": name,
      "phone": phone,
      "email": email,
      "birthDate": birthdate,
      "gitAccessToken": accessToken ?? '',
      "externalLink": {
        "notion1": "test1",
        "notion2": "test2"
      }
    };

    final String jsonData = jsonEncode(signUpData);

    final response = await http.post(
      Uri.parse('https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/signUp'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );
    print('보낼 데이터 확인: $signUpData');

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
