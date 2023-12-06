import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitme/screens/language_screen.dart';
import 'package:gitme/screens/main_screen.dart';
import 'package:gitme/widgets/github_button.dart';
import 'package:gitme/widgets/introduceFormFieldComponent.dart';
import 'package:gitme/widgets/textFormFieldComponent.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/userData.dart';
import '../widgets/githubLoginWebView.dart';

class ExternalLinkScreen extends StatefulWidget {
  static final route = 'externalLink-screen';

  @override
  _ExternalLinkScreenState createState() => _ExternalLinkScreenState();
}


class _ExternalLinkScreenState extends State<ExternalLinkScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLinked = false;


  String dropdownValue = 'tistory';
  List<String> itemList = ['tistory', 'notion', 'velog', 'github blog ', '기타'];
  Map<String, String> dropdownValues = {'tistory': 'tistory'};
  List<Widget> webpageInputs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/back_button.png', // 이미지 경로
            width: 20, // 이미지 너비
            height: 20, // 이미지 높이
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(MainScreen.route);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 36,
                        color: Color(0xFF56CC94),
                        fontFamily: 'DarkerGrotesque',
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                      ),
                    ),
                    Text(
                      "Turn",
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
                  "2 / 3",
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
            SizedBox(height: 20), // 예시로 간격 추가

            Center(
              child: Text("외부 링크는\n내가 소개하고 싶은 웹페이지예요!\n최대 5개까지 등록 가능해요",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF8D919F),
                  fontFamily: 'DarkerGrotesque',
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
                textAlign: TextAlign.center, // 가운데 정렬 추가
              ),
            ),
            SizedBox(height: 20), // 예시로 간격 추가
            Divider(),
            SizedBox(height: 20), // 예시로 간격 추가

            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: webpageInputs,
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              webpageInputs.add(buildWebpageInput());
                            });
                          },
                          child: Icon(Icons.add, color: Colors.red),
                          backgroundColor: Colors.white,

                          shape: CircleBorder(),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              if (webpageInputs.isNotEmpty) {
                                webpageInputs.removeLast();
                              }
                            });
                          },
                          child: Icon(Icons.remove, color: Colors.blueAccent,),
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ),
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
                          MaterialPageRoute(builder: (context) => LanguageScreen()),
                        );
                      },
                      child: Text('다음'),
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

  Widget buildWebpageInput() {
    return Container(
      key: UniqueKey(),
      width: double.infinity,
      child: Column(
        children: [
          buildDropdownInput(),
          buildUrlInput(),
          SizedBox(height: 20,),
          Divider()
        ],
      ),
    );
  }

  Widget buildDropdownInput() {
    String dropdownId = UniqueKey().toString(); // 각 DropdownButton에 대한 고유한 키 생성
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "* 웹페이지  ",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF8D919F),
            fontFamily: 'DarkerGrotesque',
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            child: DropdownButton<String>(
              value: dropdownValues[dropdownId], // 초기값 설정
              menuMaxHeight: 300,
              items: itemList.map((String itemText) {
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
                setState(() {
                  dropdownValues[dropdownId] = newValue ?? '';
                });
              },

              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              iconSize: 24,
              isExpanded: true,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              underline: Container(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildUrlInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "* 주소 URL  ",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF8D919F),
            fontFamily: 'DarkerGrotesque',
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}


