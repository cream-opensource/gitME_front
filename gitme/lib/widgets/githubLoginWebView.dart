import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../provider/userData.dart';

class GitHubLoginWebView extends StatefulWidget {
  final String githubLoginUrl;
  final void Function() onLinked; // Declare the onLinked callback

  GitHubLoginWebView({super.key, required this.githubLoginUrl, required this.onLinked});

  @override
  _GitHubLoginWebViewState createState() => _GitHubLoginWebViewState();
}

class _GitHubLoginWebViewState extends State<GitHubLoginWebView> {
  late WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github 로그인"),
      ),
      body: WebView(
        initialUrl: widget.githubLoginUrl,
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
      String contents = await _webViewController.runJavascriptReturningResult('document.body.innerText');

      String unescapedContents = contents.replaceAll('\\', '');

      String trimmedContents = unescapedContents.substring(1, unescapedContents.length - 1);
      Map<String, dynamic> jsonData = json.decode(trimmedContents);

      String token = jsonData['AccessToken'];
      print('AccessToken: $token');

      Provider.of<UserData>(context, listen: false).setAccessToken(token);

      widget.onLinked();

      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('연동 성공'),
            // content: Text('ID: ${jsonData['result']['id']}\nNickname: ${jsonData['result']['nickname']}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.pushReplacementNamed(dialogContext, 'join-screen');
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

