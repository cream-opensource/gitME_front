import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitme/screens/externallink_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/widgets/github_button.dart';

class BeforeLanguageScreen extends StatefulWidget {
  static final route = 'before-language-screen';

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<BeforeLanguageScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLinked = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/back_button.png',
            width: 20,
            height: 20,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(ExternalLinkScreen.route);
          },
        ),
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // 변경된 부분
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Final",
                        style: TextStyle(
                          fontSize: 36,
                          color: Color(0xFF56CC94),
                          fontFamily: 'DarkerGrotesque',
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "3 / 3",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF56CC94),
                      fontFamily: 'DarkerGrotesque',
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                    ),
                  ),
                ],
              ),
                SizedBox(height: 20),
                GitHubButton(isButtonEnabled: true),
                SizedBox(height: 20),
              ])
      ),
    );
  }

}