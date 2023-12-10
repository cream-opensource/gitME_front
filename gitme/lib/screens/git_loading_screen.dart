import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../provider/userData.dart';  // 실제 경로에 따라 수정 필요

class GitLoadingScreen extends StatefulWidget {
  static final route = 'git-loading-screen';

  @override
  _GitLoadingScreenState createState() => _GitLoadingScreenState();
}

class _GitLoadingScreenState extends State<GitLoadingScreen> {
  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate();
  }

  Future<void> _loadDataAndNavigate() async {
    // AccessToken 전송
    UserData userData = Provider.of<UserData>(context, listen: false);
    String? accessToken = userData.accessToken;

    print("토큰: $accessToken");

    if (accessToken == null) {
      print('유효하지 않은 AccessToken');
      Navigator.pushReplacementNamed(context, 'before-language-screen');
      Navigator.pop(context);
      return;
    }

    // await Future.delayed(Duration(seconds: 3));
    await _sendAccessTokenToServer(accessToken);

    // Navigator.pushReplacementNamed(context, 'after-language-screen');
  }

  Future<void> _sendAccessTokenToServer(String accessToken) async {

    final Map<String, dynamic> data = {
      'gitAccessToken': accessToken ?? '',
    };
    print(accessToken);
    try {
      final response = await http.get(
        Uri.parse('https://port-0-gitme-server-1igmo82clotquec0.sel5.cloudtype.app/github/language/$accessToken'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        Map<String, int> languageData = {};
        responseData.forEach((key, value) {
          languageData[key] = value as int;
        });
        Provider.of<UserData>(context, listen: false).setLanguageData(languageData);
        Navigator.pushReplacementNamed(context, 'after-language-screen');
      } else {
        print('서버 요청 실패임: ${response.reasonPhrase}');
        Navigator.pushReplacementNamed(context, 'before-language-screen');
        Navigator.pop(context);
      }
    } catch (error) {
      print('서버 통신 중 오류: $error');
      Navigator.pushReplacementNamed(context, 'before-language-screen');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
