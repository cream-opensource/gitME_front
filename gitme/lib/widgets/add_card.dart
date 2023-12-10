import 'package:flutter/material.dart';
import 'package:gitme/screens/createCard_screen.dart';

class AddCard extends StatelessWidget {
  AddCard();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () {
          // AddCard를 눌렀을 때 실행될 코드
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateCardScreen()),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 400,
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Color(0xFF56CC94),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Add ME!",
                style: TextStyle(
                  fontFamily: 'DarkerGrotesque',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF56CC94),
                ),
              ),
              // Image.asset(
              //   'assets/gitme_logo.png',
              //   width: 41, // 이미지 너비
              //   height: 23, // 이미지 높이
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

