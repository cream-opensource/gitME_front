import 'package:flutter/material.dart';



class AddCard extends StatelessWidget {

  AddCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      height: 400,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
          Image.asset(
            'assets/add_button.png',
            width:86, // 이미지의 가로 크기 조절
            height: 86, // 이미지의 세로 크기 조절
          ),
          SizedBox(height: 10,),
          Text("Add Card!", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
