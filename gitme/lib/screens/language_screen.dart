import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitme/screens/externallink_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/widgets/github_button.dart';

class LanguageScreen extends StatefulWidget {
  static final route = 'language-screen';

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLinked = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController introduceController = TextEditingController();

  String languageDropdownValue = 'tistory';
  List<String> languageItemList = ['tistory', 'notion', 'velog', 'github blog ', '기타'];

  String FrameLibdropdownValue = 'tistory';
  List<String> FrameLibItemList = ['tistory', 'notion', 'velog', 'github blog ', '기타'];

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
          mainAxisAlignment: MainAxisAlignment.center,
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
            GitHubButton(),
            SizedBox(height: 20),

            Center(
              child: Text(
                "노현이 님이 github 내 사용 언어",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF8D919F),
                  fontFamily: 'DarkerGrotesque',
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoundedText("Word1"),
                SizedBox(width: 5),
                _buildRoundedText("Word1"),
                SizedBox(width: 5),
                _buildRoundedText("Word1"),
              ],
            ),
            SizedBox(height: 13),
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 20,),
                  buildDropdownInput("주사용 언어", languageItemList, languageDropdownValue, (String newValue) {
                    setState(() {
                      languageDropdownValue = newValue;
                    });
                  }),
                  SizedBox(height: 20,),
                  buildDropdownInput("주사용 프레임워크 & 라이브러리", FrameLibItemList, FrameLibdropdownValue, (String newValue) {
                    setState(() {
                      FrameLibdropdownValue = newValue;
                    });
                  }),
                  SizedBox(height: 20,),

              ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      },
                      child: Text('확인'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF56CC94),
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // 모서리 조절
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ... rest of the code

  Widget _buildRoundedText(String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color(0xFF56CC94)),
        color: Color(0xFF56CC94),
      ),
      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Center(
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
      ),
    );
  }

  Widget buildDropdownInput(String key, List<String> list, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "* " + key + "  ",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF8D919F),
            fontFamily: 'DarkerGrotesque',
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: DropdownButton<String>(
            value: value,
            menuMaxHeight: 300,
            items: list.map((String itemText) {
              return DropdownMenuItem<String>(
                value: itemText,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Text(
                    itemText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              onChanged(newValue ?? '');
            },
            icon: Icon(Icons.arrow_drop_down, color: Colors.black),
            iconSize: 24,
            isExpanded: true,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(),
          ),
        ),
      ],
    );
  }

}
