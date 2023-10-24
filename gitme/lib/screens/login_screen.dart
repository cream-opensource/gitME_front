import 'package:gitme/widgets/custom_drawer_btn.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static final route = 'login-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // AppBar를 제거
      body: Column(
        children: <Widget>[
          CustomDrawerBtn(), // CustomDrawerButton 추가
          SizedBox(height: 30.0),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: <Widget>[
                // 나머지 내용
                Text("lgoin - screen")
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}