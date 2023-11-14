import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GitHubLoginWebView extends StatelessWidget {
  final String githubLoginUrl;

  GitHubLoginWebView({required this.githubLoginUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub 로그인"),
      ),
      body: WebView(
        initialUrl: githubLoginUrl,
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true, // 디버그 모드 활성화
      ),
    );
  }
}
