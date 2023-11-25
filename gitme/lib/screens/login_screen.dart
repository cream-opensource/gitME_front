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
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Image(
                    image: AssetImage('assets/gitme_logo.png'),
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: 0,
            right: 0,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: ButtonTheme(
                child: ElevatedButton(
                  onPressed: () => openWebView(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFEE20B),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Image.asset(
                          'assets/kakaoIcon.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Text(
                        '카카오로 시작하기',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
