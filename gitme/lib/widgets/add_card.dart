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
              Image.asset(
                'assets/add_button.png',
                width: 86,
                height: 86,
              ),
              SizedBox(height: 10,),
              Text("Add Card!", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}

