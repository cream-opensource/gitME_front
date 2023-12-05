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
      appBar: AppBar(
        title: Text("Kakao 로그인"),
      ),
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
      String contents = await _webViewController.evaluateJavascript('document.body.innerText');

      String unescapedContents = contents.replaceAll('\\', '');

      String trimmedContents = unescapedContents.substring(1, unescapedContents.length - 1);
      Map<String, dynamic> jsonData = json.decode(trimmedContents);

      String msg = jsonData['msg'];
      int id = jsonData['result']['id'];
      String nickname = jsonData['result']['nickname'];

      print('Message: $msg');
      print('ID: $id');
      print('Nickname: $nickname');


      Provider.of<UserData>(context, listen: false).setKId(id);

      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('로그인 성공'),
            // content: Text('ID: ${jsonData['result']['id']}\nNickname: ${jsonData['result']['nickname']}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  // #TODO: 신규가입자의 경우 join-screen으로, 기존가입자의 경우 main-screen으로
                  Navigator.pushReplacementNamed(dialogContext, 'loading-screen');
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );

    } catch (e) {
      print('Error while reading WebView contents: $e');
    }
  }
}
