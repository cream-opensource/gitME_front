import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KakaoLoginWebView extends StatelessWidget {
  final String kakaoLoginUrl;

  KakaoLoginWebView({required this.kakaoLoginUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub 로그인"),
      ),
      body: WebView(
        initialUrl: kakaoLoginUrl,
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true, // 디버그 모드 활성화
      ),
    );
  }
}
