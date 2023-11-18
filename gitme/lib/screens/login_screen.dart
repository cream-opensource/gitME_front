import 'package:flutter/material.dart';
import 'package:gitme/widgets/kakaoLoginWebView.dart';

class LoginScreen extends StatelessWidget {
  static final route = 'login-screen';

  Future<void> openWebView(BuildContext context) async {
    String kakaoLoginUrl = 'https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/kakao/login';

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => KakaoLoginWebView(kakaoLoginUrl: kakaoLoginUrl),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: const Color(0xffFFFFFF),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 150)),
          Center(
            child: Image(
              image: AssetImage('assets/gitme_logo.png'),
              width: 500.0,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ButtonTheme(
            child: ElevatedButton(
              onPressed: () => openWebView(context),
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
            ),
          )
        ],
      ),
    );
  }
}
