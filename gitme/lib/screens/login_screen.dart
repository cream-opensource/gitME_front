import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/widgets/custom_drawer_btn.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  Future<void> simulateLogin() async {
    final response = await http
        .get(Uri.parse('https://0b22-210-206-182-220.ngrok-free.app/login'));

    if (response.statusCode == 200) {
      print('데이터: ${response.body}');
    } else {
      print('요청 실패: ${response.reasonPhrase}');
    }
  }

  static final route = 'login-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // AppBar를 제거
      backgroundColor: const Color(0xff000E1B),
      body: Column(children: [
        Padding(padding: EdgeInsets.only(top: 150)),
        Center(
          child: Image(
            image: AssetImage('assets/gitme_logo.png'),
            width: 170.0,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        ButtonTheme(
            child: ElevatedButton(
              onPressed: () =>
              {
                simulateLogin(),
                Navigator.pushReplacementNamed(context, MainScreen.route),
              },
              child: Text("Kakao Login"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellowAccent,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ))
      ]),
      drawer: MainDrawer(),
    );
  }
}
