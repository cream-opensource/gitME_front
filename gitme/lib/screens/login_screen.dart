import 'package:flutter/material.dart';
import 'package:gitme/widgets/kakaoLoginWebView.dart';

class LoginScreen extends StatelessWidget {
  static const route = 'login-screen';
  static const kakaoLoginUrl = 'https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/kakao/login';
  static const backgroundColor = Color(0xffFFFFFF);
  static const buttonColor = Color(0xffFEE20B);
  static const buttonTextColor = Colors.black;
  static const logoAsset = 'assets/gitME_logo.png';
  static const kakaoIconAsset = 'assets/kakaoIcon.png';

  const LoginScreen({super.key});

  Future<void> openWebView(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => KakaoLoginWebView(kakaoLoginUrl: kakaoLoginUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceWidth = mediaQuery.size.width;
    final deviceHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    logoAsset,
                    width: deviceWidth * 0.8,
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
          Positioned(
            bottom: deviceHeight * 0.05,
            left: 0,
            right: 0,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: ElevatedButton(
                onPressed: () => openWebView(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: buttonTextColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Image.asset(
                        kakaoIconAsset,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    Text(
                      '카카오로 시작하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff333333),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
