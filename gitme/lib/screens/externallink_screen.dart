import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitme/screens/join_screen.dart';
import 'package:gitme/screens/language_screen_after.dart';
import 'package:gitme/screens/launguage_screen_before.dart';
import 'package:provider/provider.dart';

import '../provider/userData.dart';


class ExternalLinkScreen extends StatefulWidget {
  static final route = 'externalLink-screen';

  @override
  _ExternalLinkScreenState createState() => _ExternalLinkScreenState();
}


class _ExternalLinkScreenState extends State<ExternalLinkScreen> {
  List<TextEditingController> urlControllers = [];
  Map<String, String> selectedWebpages = {};
  final itemList = ['tistory', 'notion', 'velog', 'github blog ', '기타'];
  List<String> dropdownValues = ['tistory', 'notion', 'velog', 'github blog ', '기타'];
  List<List<String>> dropdownValuesList = [[]];
  String dropdownValue = "tistory";
  List<String> dropdownItemList = ['tistory', 'notion', 'velog', 'github blog ', '기타'];


  List<Widget> webpageInputs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : true,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/back_button.png', // 이미지 경로
            width: 20, // 이미지 너비
            height: 20, // 이미지 높이
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(JoinScreen.route);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
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

            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Text("외부 링크는\n내가 소개하고 싶은 웹페이지예요!\n최대 5개까지 등록 가능해요",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontFamily: 'DarkerGrotesque',
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                      ),
                      textAlign: TextAlign.center, // 가운데 정렬 추가
                    ),
                  ),
                  SizedBox(height: 10,),
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
                              webpageInputs.add(buildWebpageInput(webpageInputs.length));
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
                        List<Map<String, String>> userDataList = [];

                        for (int i = 0; i < urlControllers.length; i++) {

                          String selectedWebpage = dropdownValuesList[i].isNotEmpty
                              ? dropdownValuesList[i].first
                              : '';
                          TextEditingController urlController = urlControllers[i];
                          String url = urlController.text;

                          print('Webpage: $selectedWebpage, URL: $url');

                          userDataList.add({
                            'webpage': selectedWebpage,
                            'url': url,
                          });
                        }

                        print('User Data: $userDataList');

                        Map<String, String> convertedData = userDataList.fold({}, (result, item) {
                          result.addAll(item);
                          return result;
                        });

                        print(convertedData);

                        UserData userData = Provider.of<UserData>(context, listen: false);
                        userData.setExternalLinkData(userDataList);
                        userData.notifyListeners();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BeforeLanguageScreen()),
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

  Widget buildWebpageInput(int index) {
    // 웹페이지 종류 입력을 위한 TextEditingController
    TextEditingController typeController = TextEditingController();
    // URL 입력을 위한 TextEditingController
    TextEditingController urlController = TextEditingController();

    // 컨트롤러 목록에 추가
    urlControllers.add(urlController);
    dropdownValuesList.add([]);

    return Container(
      key: UniqueKey(),
      width: double.infinity,
      child: Column(
        children: [
          buildTextInput("웹페이지 종류", typeController), // 웹페이지 종류 입력 필드
          buildTextInput("주소 URL", urlController), // URL 입력 필드
          SizedBox(height: 20),
          Divider(),
        ],
      ),
    );
  }

  Widget buildTextInput(String labelText, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "* $labelText  ",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontFamily: 'DarkerGrotesque',
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            child: TextField(
              controller: controller,
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


  Widget buildUrlInput(TextEditingController urlController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "* 주소 URL  ",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontFamily: 'DarkerGrotesque',
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            child: TextField(
              controller: urlController,
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