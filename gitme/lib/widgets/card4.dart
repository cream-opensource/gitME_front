import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/business_card_data.dart';


class BusinessCard4 extends StatelessWidget {
  final BusinessCardData data;
  final url = Uri.parse(
    'https://deku.posstree.com/en/',
  );

  BusinessCard4(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.8,
      height: 400,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFDBC3EA),
            Color(0xFFDBC3EA),
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
          ],
          stops: [0.0, 0.6, 0.4, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        color: Color(0xFFDBC3EA),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  data.avatarUrl,
                  fit: BoxFit.cover,
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  data.nickname,
                  style: TextStyle(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'DarkerGrotesque',
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.01),
            Text(
              data.introduction ?? "",
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                color: Colors.white,
                fontFamily: 'DarkerGrotesque',
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: data.externalLink?.entries.map((entry) {
                    return ElevatedButton(
                      onPressed: () async {
                        final uri = Uri.parse(entry.value);
                        try {
                          await launch(
                            uri.toString(),
                            forceWebView: true,
                          );
                        } catch (e) {
                          print('Error launching URL: $e');
                        }
                      },
                      child: Text(entry.key),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFD2AFE3),
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontSize: screenWidth * 0.03),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                      ),
                    );
                  }).toList() ?? [],
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            Text("Stack", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.03)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: data.languages?.keys.map((language) {
                  return Container(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        print('Button pressed: $language');
                      },
                      child: Text(language),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFD2AFE3),
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontSize: screenWidth * 0.03),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.05),
                        ),
                      ),

                    ),
                    padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                  );
                }).toList() ?? [],
              )
            ),
            SizedBox(height: screenWidth * 0.008),
            Text("Info", style: TextStyle(color: Color(0xFF8B8B91), fontSize: screenWidth * 0.03)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Text(
                          "Commit",
                          style: TextStyle(
                            fontSize: screenWidth * 0.02,
                          ),
                        ),
                        Text(
                          data.totalCommits,
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Text(
                          "Stars",
                          style: TextStyle(
                            fontSize: screenWidth * 0.02,
                          ),
                        ),
                        Text(
                          data.totalStars,
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Text(
                          "Followers",
                          style: TextStyle(
                            fontSize: screenWidth * 0.02,
                          ),
                        ),
                        Text(
                          data.followers,
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFD2AFE3),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                    ),
                  ),
                  // Add more buttons as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
