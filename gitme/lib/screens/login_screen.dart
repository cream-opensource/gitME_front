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
            child: ElevatedButton(onPressed: () =>
              Navigator.pushReplacementNamed(context, MainScreen.route)
            ,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 35.0,
              ),
            ))
      ]),
      drawer: MainDrawer(),
    );
  }
}
