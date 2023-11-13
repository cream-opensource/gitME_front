import 'package:flutter/material.dart';
import 'package:gitme/widgets/textFormFieldComponent.dart';
import 'package:http/http.dart' as http;

class JoinScreen extends StatelessWidget {
  static final route = 'join-screen';

  final formKey = GlobalKey<FormState>();

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
                    false,
                    TextInputType.text,
                    TextInputAction.next,
                    "이름",
                    2,
                    "이름을 입력하세요",
                  ),
                  SizedBox(height: 16.0),
                  TextFormFieldComponent(
                    false,
                    TextInputType.phone,
                    TextInputAction.next,
                    "전화번호",
                    11,
                    "'-'없이 숫자로만 입력하세요",
                  ),
                  SizedBox(height: 16.0),
                  TextFormFieldComponent(
                    false,
                    TextInputType.emailAddress,
                    TextInputAction.next,
                    "이메일",
                    10,
                    "이메일을 입력하세요",
                  ),
                  SizedBox(height: 16.0),
                  TextFormFieldComponent(
                    false,
                    TextInputType.datetime,
                    TextInputAction.done,
                    "생년월일",
                    8,
                    "생년월일을 입력하세요",
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        String name = nameController.text;
                        String phone = phoneController.text;
                        String email = emailController.text;
                        String birthdate = birthdateController.text;
                        await sendUserDataToServer(name, phone, email, birthdate);
                      }
                    },
                    child: Text("가입 완료"),
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
      String name, String phone, String email, String birthdate) async {
    final response = await http.post(
      Uri.parse('https://0b22-210-206-182-220.ngrok-free.app/login'),
      body: {
        'name': name,
        'phone': phone,
        'email': email,
        'birthdate': birthdate,
      },
    );

    if (response.statusCode == 200) {
      print('데이터: ${response.body}');
    } else {
      print('요청 실패: ${response.reasonPhrase}');
    }
  }
}
