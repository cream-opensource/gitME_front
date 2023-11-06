import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/widgets/custom_drawer_btn.dart';
import 'package:gitme/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static final route = 'login-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // AppBar를 제거
      body: Column(children: [
        Padding(padding: EdgeInsets.only(top: 150)),
        Center(
          child: Image(
            image: AssetImage('assets/cream.png'),
            width: 170.0,
          ),
        ),
        SizedBox(height: 40,),
        ButtonTheme(
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, MainScreen.route),
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
            )
        )
      ]),
      drawer: MainDrawer(),
    );
  }
}
