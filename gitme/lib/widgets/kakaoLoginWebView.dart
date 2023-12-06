import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../provider/userData.dart';

class KakaoLoginWebView extends StatefulWidget {
  final String kakaoLoginUrl;

  KakaoLoginWebView({super.key, required this.kakaoLoginUrl});

  @override
  _KakaoLoginWebViewState createState() => _KakaoLoginWebViewState();
}

class _KakaoLoginWebViewState extends State<KakaoLoginWebView> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: WebView(
        initialUrl: widget.kakaoLoginUrl,
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true,
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onPageFinished: (url) {
          _readWebViewContents();
        },
      ),
    );
  }

  Future<void> _readWebViewContents() async {
    try {
      // 변경: evaluateJavascript -> runJavascriptReturningResult
      String contents = await _webViewController
          .runJavascriptReturningResult('document.body.innerText');

      String unescapedContents = contents.replaceAll('\\', '');

      String trimmedContents =
          unescapedContents.substring(1, unescapedContents.length - 1);
      Map<String, dynamic> jsonData = json.decode(trimmedContents);

      String msg = jsonData['msg'];
      int id = jsonData['result']['id'];
      String nickname = jsonData['result']['nickname'];

      print('Message: $msg');
      print('ID: $id');
      print('Nickname: $nickname');

      Provider.of<UserData>(context, listen: false).setKId(id);
      Navigator.pushReplacementNamed(context, 'loading-screen');
    } catch (e) {
      print('Error while reading WebView contents: $e');
    }
  }
}
