import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatelessWidget {
  static final route = 'login-screen';

  Future<void> openWebView(BuildContext context) async {
    String webViewUrl = 'https://d750-210-206-182-220.ngrok-free.app/kakao/login';

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebViewPage(webViewUrl: webViewUrl),
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

class WebViewPage extends StatelessWidget {
  final String webViewUrl;

  WebViewPage({required this.webViewUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kakao Login"),
      ),
      body: WebView(
        initialUrl: webViewUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
