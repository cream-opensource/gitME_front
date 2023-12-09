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
      appBar: null,
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
      Navigator.pushReplacementNamed(context, 'language-screen');

    } catch (e) {
      print('Error while reading WebView contents: $e');
    }
  }
}

